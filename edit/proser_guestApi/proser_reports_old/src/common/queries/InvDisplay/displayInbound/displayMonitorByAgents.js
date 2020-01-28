import * as pool from "../../../../connectors/pool";
import moment from "moment";
// import userSelectionFilters from "../../InvMenu/userSelection/userSelectionFilters";

import {
  dateAndTimeSqlQuery,
  dateAndTimeSqlQueryRealTime,
  arrayToSqlQuery,
  arrayToJsonSqlQuery,
  sqlIntervalSqlQuery,
  sqlIntervalGroupSqlQuery
} from "../../../functions/sqlFunctions";

/******************************************************************** */

export async function displayMonitorByAgents(userSelection) {
  // DEFINE VARIABLES
  let result = {
    now: moment().format("YYYY-MM-DD hh:mm:ss"),
    total: [],
    detail: []
  };

  if ((userSelection.mode.name = "Actual")) {
    userSelection.start_date = userSelection.current_date;
    userSelection.end_date = userSelection.end_date;
  }

  /* DETAIL ********************************* */
  let queryDetail = `
   SELECT
     ${detailFields(userSelection)}
   FROM
     ${query(userSelection)}
 `;

  try {
    result.detail = await pool.destiny.query(queryDetail);
  } catch (error) {
    result.detail = { errorDetail: error };
  }

  /* TOTAL ********************************* */
  let queryTotal = `
   SELECT
     ${totalFields(userSelection)}
   FROM
     (${queryDetail}) AS detail
   `;

  try {
    result.total = await pool.destiny.query(queryTotal);
  } catch (error) {
    result.total = { errorTotal: error };
  }

  return result;
}

// TOTAL FIELDS
function totalFields(userSelection) {
  return `
  DATE(now()) as now_date
  ,TIME(now()) as now_time
  ,'' as queueName
  ,SUM(activeCalls) as activeCalls
  ,SUM(agentsLogin) as agentsLogin
  ,SUM(agentsAvailable) as agentsAvailable
  ,SUM(agentsBusy) as agentsBusy
  ,SUM(agentsBreak) as agentsBreak
  ,SUM(agentsAssignation) as agentsAssignation
  
  `;
}

/******************************************************* */
// DETAIL FIELDS
function detailFields(userSelection) {
  return `
  DATE(now()) as now_date
  ,TIME(now()) as now_time
  ,inv_queue_shortname as queueName
  ,CALLS.activeCalls as activeCalls
  ,AUDIT.agentsLogin as agentsLogin
  ,AUDIT.agentsAvailable as agentsAvailable
  ,AUDIT.agentsBusy as agentsBusy
  ,AUDIT.agentsBreak as agentsBreak
  ,AUDIT.agentsAssignation as agentsAssignation

  `;
}

/********************************************************* */
// MAIN QUERY
function query(userSelection) {
  return `

  InvQueue

  LEFT OUTER JOIN
  (${auditQuery(userSelection)}) as AUDIT
  ON inv_queue_id = AUDIT.queueId

  LEFT OUTER JOIN
  (${callsQuery(userSelection)}) as CALLS
  ON inv_queue_id = CALLS.queueId

  WHERE
  inv_queue_status = 'A'

  GROUP BY inv_queue_shortname


-- ---------------------------------------------------------------
-- END
`;
}

function auditQuery(userSelection) {
  return `
-- ---------------------------------------------------------------
-- FIELDS
SELECT

JSON_UNQUOTE(JSON_EXTRACT(JSON_EXTRACT(audit_operation_json, '$.queue[*].name'), '$[0]')) as queueName
,JSON_EXTRACT(JSON_EXTRACT(audit_operation_json, '$.queue[*].id'), '$[0]') as queueId
,SUM(case when (audit_datetime_end is null AND audit_break_id is null) then 1 else 0 end) as agentsLogin
,SUM(case when (rca_agent_status = 'Logueado' AND rca_group_name = 'Disponible') then 1 else 0 end) as agentsAvailable
,SUM(case when (rca_agent_status = 'Logueado' AND rca_group_name = 'Ocupado') then 1 else 0 end) as agentsBusy
,SUM(case when (audit_datetime_end is null AND audit_break_id is not null AND inv_break_productivity = 0) then 1 else 0 end) as agentsBreak
,SUM(case when (audit_datetime_end is null AND audit_break_id is not null AND inv_break_productivity = 1) then 1 else 0 end) as agentsAssignation

FROM
RealAudit

LEFT OUTER JOIN RealCurrentAgents
ON audit_id = rca_audit_login_id

LEFT OUTER JOIN InvBreak
ON audit_break_id = inv_break_id

-- ---------------------------------------------------------------
-- CONDITIONS
WHERE 1

-- TIME AND DATE
${dateAndTimeSqlQueryRealTime(userSelection, "audit_datetime_init")}

GROUP BY queueName

-- ---------------------------------------------------------------
-- END
 `;
}

function callsQuery(userSelection) {
  return `
-- ---------------------------------------------------------------
-- FIELDS
SELECT
inv_queue_shortname as queueName
,rcc_callentry_queue_id as queueId
,SUM(case when rcc_callentry_status = 'activa' then 1 else 0 end) as activeCalls

FROM
RealCurrentCalls

LEFT OUTER JOIN InvQueue
ON rcc_callentry_queue_id = inv_queue_id

-- ---------------------------------------------------------------
-- CONDITIONS
WHERE 1

-- TIME AND DATE
${dateAndTimeSqlQueryRealTime(
    userSelection,
    "rcc_callentry_datetime_entry_queue"
  )}

GROUP BY
inv_queue_name

-- ---------------------------------------------------------------
-- END
 `;
}
