import * as pool from "../../../../connectors/pool";

// import userSelectionFilters from "../../InvMenu/userSelection/userSelectionFilters";

import {
  dateAndTimeSqlQuery,
  arrayToSqlQuery,
  arrayToJsonSqlQuery,
  objectToJsonSqlQuery,
  sqlIntervalSqlQuery,
  sqlIntervalGroupSqlQuery
} from "../../../functions/sqlFunctions";

import { objectDateToTextDate } from "../../../functions/dateFunctions";

/******************************************************************** */

export async function operationDetailOperationReport(userSelection) {
  let result = "";

  let query = `
  SELECT

  base_date
  , agent_id
  , agent_name
  -- SAME DATA IN ALL
  , login_duration_sec
  , login_duration_time
  , inbound_calls_attended
  , inbound_attended_duration_sec
  , inbound_attended_duration_time
  , inbound_attended_duration_sec/login_duration_sec as inbound_percent
  , outbound_calls_made
  , outbound_made_sec
  , outbound_made_time
  , outbound_made_sec/login_duration_sec as outbound_percent
  , outbound_internal_made
  , outbound_internal_sec
  , outbound_internal_time
  , outbound_internal_sec/login_duration_sec as internal_percent
  , auxiliar_duration_sec
  , auxiliar_duration_time
  , auxiliar_duration_sec/login_duration_sec as auxiliar_percent
  , assignation_duration_sec
  , assignation_duration_time
  , assignation_duration_sec/login_duration_sec as assignation_percent
  , MAIN.login_duration_sec - MAIN.inbound_attended_duration_sec - MAIN.outbound_made_sec - MAIN.auxiliar_duration_sec - MAIN.assignation_duration_sec as available_duration_sec
  , SEC_TO_TIME(login_duration_sec - inbound_attended_duration_sec - outbound_made_sec - auxiliar_duration_sec - assignation_duration_sec) as available_duration_time
  , (login_duration_sec - inbound_attended_duration_sec - outbound_made_sec - auxiliar_duration_sec - assignation_duration_sec) /
      login_duration_sec as available_percent
  
    FROM
      (${preFinalQuery(userSelection)}) as MAIN

    GROUP BY 
      agent_id, base_date
  `;

  try {
    let resultPre = await pool.destinyReports.query(query);
    result = resultPre;
  } catch (error) {
    result = { error: error };
  }

  return result;
}

/******************************* 3rd LEVEL QUERIES ************************************ */

function preFinalQuery(userSelection){
 
  
  return `

SELECT
     
base_date
, agent_id
, agent_name
-- SAME DATA IN ALL

, SUM(IF(login_duration_sec is not null, login_duration_sec, 0)) as login_duration_sec
, SEC_TO_TIME(SUM(IF(login_duration_sec is not null, login_duration_sec, 0))) as login_duration_time


, SUM(IF(inbound_calls_attended is not null, inbound_calls_attended, 0)) as inbound_calls_attended
, SUM(IF(inbound_attended_duration_sec is not null, inbound_attended_duration_sec, 0)) as inbound_attended_duration_sec
, SEC_TO_TIME(SUM(IF(inbound_attended_duration_sec is not null, inbound_attended_duration_sec, 0))) as inbound_attended_duration_time

, SUM(IF(outbound_calls_made is not null, outbound_calls_made, 0)) as outbound_calls_made
, SUM(IF(outbound_made_sec is not null, outbound_made_sec, 0)) as outbound_made_sec
, SEC_TO_TIME(SUM(IF(outbound_made_sec is not null, outbound_made_sec, 0))) as outbound_made_time

, SUM(IF(outbound_internal_made is not null, outbound_internal_made, 0)) as outbound_internal_made
, SUM(IF(outbound_internal_sec is not null, outbound_internal_sec, 0)) as outbound_internal_sec
, SEC_TO_TIME(SUM(IF(outbound_internal_made is not null, outbound_internal_made, 0))) as outbound_internal_time
, SUM(IF(auxiliar_duration_sec is not null, auxiliar_duration_sec, 0)) as auxiliar_duration_sec
, SEC_TO_TIME(SUM(IF(auxiliar_duration_sec is not null, auxiliar_duration_sec, 0))) as auxiliar_duration_time
, SUM(IF(assignation_duration_sec is not null, assignation_duration_sec, 0)) as assignation_duration_sec
, SEC_TO_TIME(SUM(IF(assignation_duration_sec is not null, assignation_duration_sec, 0))) as assignation_duration_time


FROM 
  (${unionQuery(userSelection)}) AS BASE


GROUP BY 
    agent_id, base_date


`;
  
}

/******************************* 2nd LEVEL QUERIES ************************************ */

function unionQuery(userSelection){

  return `
  ${auditConecctionQuery(userSelection)}

  -- ------------------------------
  UNION

  ${callentryQuery(userSelection)}

  -- ------------------------------
  UNION

  ${cdrQuery(userSelection)}

  -- ------------------------------
  UNION

  ${auditAuxiliarQuery(userSelection)}

  -- ------------------------------
  UNION

  ${auditAssignationQuery(userSelection)}


  `;
}

/******************************* 1st LEVEL QUERIES ************************************ */

function auditConecctionQuery(userSelection) {
  return `
-- ---------------------------------------------------------------
-- FIELDS
SELECT

-- TIME & INTERVAL

DATE_FORMAT(audit_datetime_init, '%Y-%m-%d') as base_date
, audit_agent_id as agent_id
, inv_agent_name as agent_name
-- SAME DATA IN ALL
,IF(audit_datetime_end is null, SUM(TIMESTAMPDIFF(second,audit_datetime_init,now())), SUM(audit_duration_sec)) as login_duration_sec
,null as inbound_calls_attended
,null as inbound_attended_duration_sec
,null as outbound_calls_made
,null as outbound_made_sec
,null as outbound_internal_made
,null as outbound_internal_sec
,null as auxiliar_duration_sec
,null as assignation_duration_sec


-- ---------------------------------------------------------------
-- TABLES & JOINS

FROM

MainAudit
LEFT OUTER JOIN InvAgent
ON audit_agent_id = inv_agent_id

LEFT OUTER JOIN InvBreak
ON audit_break_id = inv_break_id

-- ---------------------------------------------------------------
-- CONDITIONS
WHERE 1

AND
audit_break_id is null

-- TIME AND DATE
${dateAndTimeSqlQuery(userSelection, "audit_datetime_init")}

-- AGENT
${arrayToSqlQuery(userSelection.agent, "audit_agent_id")}


GROUP BY agent_id, base_date

-- ---------------------------------------------------------------
-- END
 `;
}

function auditAuxiliarQuery(userSelection) {
  return `
-- ---------------------------------------------------------------
-- FIELDS
SELECT

-- TIME & INTERVAL

DATE_FORMAT(audit_datetime_init, '%Y-%m-%d') as base_date
, audit_agent_id as agent_id
, inv_agent_name as agent_name
-- SAME DATA IN ALL
,null as login_duration_sec
,null as inbound_calls_attended
,null as inbound_attended_duration_sec
,null as outbound_calls_made
,null as outbound_made_sec
,null as outbound_internal_made
,null as outbound_internal_sec
,IF(audit_datetime_end is null, TIMESTAMPDIFF(second,audit_datetime_init,now()), SUM(audit_duration_sec)) as auxiliar_duration_sec
,null as assignation_duration_sec


-- ---------------------------------------------------------------
-- TABLES & JOINS

FROM

MainAudit
LEFT OUTER JOIN InvAgent
ON audit_agent_id = inv_agent_id

LEFT OUTER JOIN InvBreak
ON audit_break_id = inv_break_id

-- ---------------------------------------------------------------
-- CONDITIONS
WHERE 1

AND
audit_break_id is not null
AND
inv_break_productivity = 0

-- TIME AND DATE
${dateAndTimeSqlQuery(userSelection, "audit_datetime_init")}

-- AGENT
${arrayToSqlQuery(userSelection.agent, "audit_agent_id")}


GROUP BY agent_id, base_date

-- ---------------------------------------------------------------
-- END
 `;
}

function auditAssignationQuery(userSelection) {
  return `
-- ---------------------------------------------------------------
-- FIELDS
SELECT

-- TIME & INTERVAL

DATE_FORMAT(audit_datetime_init, '%Y-%m-%d') as base_date
, audit_agent_id as agent_id
, inv_agent_name as agent_name
-- SAME DATA IN ALL
,null as login_duration_sec
,null as inbound_calls_attended
,null as inbound_attended_duration_sec
,null as outbound_calls_made
,null as outbound_made_sec
,null as outbound_internal_made
,null as outbound_internal_sec
,null as auxiliar_duration_sec
,IF(audit_datetime_end is null, TIMESTAMPDIFF(second,audit_datetime_init,now()), SUM(audit_duration_sec)) as assignation_duration_sec


-- ---------------------------------------------------------------
-- TABLES & JOINS

FROM

MainAudit
LEFT OUTER JOIN InvAgent
ON audit_agent_id = inv_agent_id

LEFT OUTER JOIN InvBreak
ON audit_break_id = inv_break_id

-- ---------------------------------------------------------------
-- CONDITIONS
WHERE 1

AND
audit_break_id is not null
AND
inv_break_productivity = 1

-- TIME AND DATE
${dateAndTimeSqlQuery(userSelection, "audit_datetime_init")}

-- AGENT
${arrayToSqlQuery(userSelection.agent, "audit_agent_id")}


GROUP BY agent_id, base_date

-- ---------------------------------------------------------------
-- END
 `;
}

function cdrQuery(userSelection) {
  return `
-- ---------------------------------------------------------------
-- MAINCDR FIELDS
SELECT

-- TIME & INTERVAL

DATE_FORMAT(cdr_calldate, '%Y-%m-%d') as base_date
, cdr_agent_id as agent_id
, inv_agent_name as agent_name
-- SAME DATA IN ALL
,null as login_duration_sec
,null as inbound_calls_attended
,null as inbound_attended_duration_sec
,IF(cdr_call_type = 'outbound', SUM(cdr_call_made), 0) as outbound_calls_made
,IF(cdr_call_type = 'outbound', SUM(cdr_duration_sec), 0) as outbound_made_sec
,IF(cdr_call_type = 'internal', SUM(cdr_call_made), 0) as outbound_internal_made
,IF(cdr_call_type = 'internal', SUM(cdr_duration_sec), 0) as outbound_internal_sec
,null as auxiliar_duration_sec
,null as assignation_duration_sec

-- ---------------------------------------------------------------
-- TABLES & JOINS

FROM

MainCdr
LEFT OUTER JOIN InvAgent
ON cdr_agent_id = inv_agent_id

LEFT OUTER JOIN InvQueue
ON cdr_queue_id = inv_queue_id

LEFT OUTER JOIN MainCallEntry
ON cdr_uniqueid = callentry_uniqueid


-- ---------------------------------------------------------------
-- CONDITIONS
WHERE 1

AND
cdr_call_made = 1
AND
cdr_agent_id is not null

-- TIME AND DATE
${dateAndTimeSqlQuery(userSelection, "cdr_calldate")}

-- AGENT
${arrayToSqlQuery(userSelection.agent, "cdr_agent_id")}


GROUP BY base_date, agent_id

-- ---------------------------------------------------------------
-- END
`;
}

function callentryQuery(userSelection) {
  return `
-- ---------------------------------------------------------------
-- FIELDS
SELECT

-- TIME & INTERVAL

DATE_FORMAT(callentry_datetime_init, '%Y-%m-%d') as base_date
, callentry_agent_id as agent_id
, inv_agent_name as agent_name
-- SAME DATA IN ALL
,null as login_duration_sec
,IF(callentry_status = 'terminada', COUNT(callentry_id), 0) as inbound_calls_attended
,IF(callentry_status = 'terminada', SUM(callentry_duration_sec), 0) as inbound_attended_duration_sec
,null as outbound_calls_made
,null as outbound_made_sec
,null as outbound_internal_made
,null as outbound_internal_sec
,null as auxiliar_duration_sec
,null as assignation_duration_sec


-- ---------------------------------------------------------------
-- TABLES & JOINS

FROM

MainCallEntry
LEFT OUTER JOIN InvAgent
ON callentry_agent_id = inv_agent_id

LEFT OUTER JOIN InvQueue
ON callentry_queue_id = inv_queue_id

-- ---------------------------------------------------------------
-- CONDITIONS
WHERE 1
AND
inv_queue_type = 'inbound'

-- TIME AND DATE
${dateAndTimeSqlQuery(userSelection, "callentry_datetime_init")}

-- AGENT
${arrayToSqlQuery(userSelection.agent, "callentry_agent_id")}


GROUP BY agent_id, base_date

-- ---------------------------------------------------------------
-- END
 `;
}
