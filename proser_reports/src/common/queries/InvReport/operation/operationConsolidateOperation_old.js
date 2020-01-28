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

export async function operationConsolidateOperationReport(userSelection) {
 
  let result = "";

  let query = `
  SELECT

     agent_id
    ,agent_name
    ,start_date
    ,date_init_interval
    ,date_end_interval
    ,supervisor_name
    ,login_duration_sec
    ,login_duration_time
    ,inbound_calls_attended
    ,inbound_attended_duration_sec
    ,inbound_attended_duration_time
    ,inbound_attended_avg_time
    ,outbound_calls_made
    ,outbound_made_sec
    ,outbound_made_time
    ,outbound_made_avg_time
    ,outbound_internal_made
    ,outbound_internal_sec
    ,outbound_internal_time
    ,outbound_internal_avg_time
    ,auxiliar_duration_sec
    ,auxiliar_duration_time
    ,percent_auxiliar
    ,assignation_duration_sec
    ,assignation_duration_time
    ,percent_assignation
    ,login_duration_sec - inbound_attended_duration_sec - outbound_made_sec - auxiliar_duration_sec - assignation_duration_sec as available_sec
    ,SEC_TO_TIME(login_duration_sec - inbound_attended_duration_sec - outbound_made_sec - auxiliar_duration_sec - assignation_duration_sec) as available_time
    ,IF((login_duration_sec - inbound_attended_duration_sec - outbound_made_sec - auxiliar_duration_sec - assignation_duration_sec)/
    login_duration_sec is not null,
      (login_duration_sec - inbound_attended_duration_sec - outbound_made_sec - auxiliar_duration_sec - assignation_duration_sec)/
    login_duration_sec, 
        0) as available_percent
  
    FROM
      (${mainQuery(userSelection)}) as MAIN

    GROUP BY 
      agent_id
      `;

  
  try {
    let resultPre = await pool.destinyReports.query(query);
    result = resultPre;
  } catch (error) {
    result = { error: error };
  }
    
  return result;
}
    
function mainQuery(userSelection){

  return `

SELECT

  hca_agent_id as agent_id
  ,hca_agent_name as agent_name
  ,hca_agent_date as start_date
  ,'${objectDateToTextDate(userSelection.start_date)}' as date_init_interval
  ,'${objectDateToTextDate(userSelection.end_date)}' as date_end_interval
  ,CALLENTRY.supervisor_name as supervisor_name
  ,IF(CONNECT.login_duration_sec is not null, CONNECT.login_duration_sec, 0) as login_duration_sec
  ,IF(CONNECT.login_duration_time is not null, CONNECT.login_duration_time, 0) as login_duration_time
  ,IF(CALLENTRY.inbound_calls_attended is not null, CALLENTRY.inbound_calls_attended, 0) as inbound_calls_attended
  ,IF(CALLENTRY.inbound_attended_duration_sec is not null, CALLENTRY.inbound_attended_duration_sec, 0) as inbound_attended_duration_sec
  ,IF(CALLENTRY.inbound_attended_duration_time is not null, CALLENTRY.inbound_attended_duration_time, 0) as inbound_attended_duration_time
  ,IF(CALLENTRY.inbound_attended_duration_sec/CONNECT.login_duration_sec is not null, CALLENTRY.inbound_attended_duration_sec/CONNECT.login_duration_sec, 0) as inbound_attended_avg_time
  ,IF(CDR.outbound_calls_made is not null, CDR.outbound_calls_made, 0) as outbound_calls_made
  ,IF(CDR.outbound_made_sec is not null, CDR.outbound_made_sec, 0) as outbound_made_sec
  ,IF(CDR.outbound_made_time is not null, CDR.outbound_made_time, 0) as outbound_made_time
  ,IF(CDR.outbound_made_sec/login_duration_sec is not null, CDR.outbound_made_sec/login_duration_sec, 0) as outbound_made_avg_time
  ,IF(CDR.outbound_internal_made is not null, CDR.outbound_internal_made, 0) as outbound_internal_made
  ,IF(CDR.outbound_internal_sec is not null, CDR.outbound_internal_sec, 0) as outbound_internal_sec
  ,IF(CDR.outbound_internal_time is not null, CDR.outbound_internal_time, 0) as outbound_internal_time
  ,IF(CDR.outbound_internal_sec/login_duration_sec is not null, CDR.outbound_internal_sec/login_duration_sec, 0) as outbound_internal_avg_time
  ,IF(AUXILIAR.auxiliar_duration_sec is not null, AUXILIAR.auxiliar_duration_sec, 0) as auxiliar_duration_sec
  ,IF(AUXILIAR.auxiliar_duration_time is not null, AUXILIAR.auxiliar_duration_time, 0) as auxiliar_duration_time
  ,IF(AUXILIAR.auxiliar_duration_sec/CONNECT.login_duration_sec is not null, AUXILIAR.auxiliar_duration_sec/CONNECT.login_duration_sec, 0) as percent_auxiliar
  ,IF(ASSIGNATION.assignation_duration_sec is not null, ASSIGNATION.assignation_duration_sec, 0) as assignation_duration_sec
  ,IF(ASSIGNATION.assignation_duration_time is not null, ASSIGNATION.assignation_duration_time, 0) as assignation_duration_time
  ,IF(ASSIGNATION.assignation_duration_sec/CONNECT.login_duration_sec is not null, ASSIGNATION.assignation_duration_sec/CONNECT.login_duration_sec, 0) as percent_assignation


FROM HcaAgent

    LEFT OUTER JOIN
    (${auditConecctionQuery(userSelection)}) as CONNECT
    ON (hca_agent_id = CONNECT.audit_agent_id
    AND hca_agent_date = CONNECT.login_start_date)

    LEFT OUTER JOIN
    (${cdrQuery(userSelection)}) as CDR
    ON (hca_agent_id = CDR.cdr_agent_id
    AND hca_agent_date = CDR.outbound_start_date)

    LEFT OUTER JOIN
    (${callentryQuery(userSelection)}) as CALLENTRY
    ON (hca_agent_id = CALLENTRY.callentry_agent_id
    AND hca_agent_date = CALLENTRY.inbound_start_date)

    LEFT OUTER JOIN
    (${auditAuxiliarQuery(userSelection)}) as AUXILIAR
    ON (hca_agent_id = AUXILIAR.audit_agent_id
    AND hca_agent_date = AUXILIAR.auxiliar_start_date)

    LEFT OUTER JOIN
    (${auditAssignationQuery(userSelection)}) as ASSIGNATION
    ON (hca_agent_id = ASSIGNATION.audit_agent_id
    AND hca_agent_date = ASSIGNATION.assignation_start_date)

 WHERE
     hca_agent_date BETWEEN '${objectDateToTextDate(userSelection.start_date)}' AND '${objectDateToTextDate(userSelection.end_date)}'

     -- AGENT
     ${arrayToSqlQuery(userSelection.agent, "hca_agent_id")}
   
     -- SUPERVISOR
     ${objectToJsonSqlQuery(
    userSelection.supervisor,
    "hca_agent_people_json",
    "supervisor"
  )}
   
     -- SCHEDULE
     ${objectToJsonSqlQuery(userSelection.client, "hca_agent_time_json", "schedule")}
   
     -- ROLE
     ${objectToJsonSqlQuery(userSelection.client, "hca_agent_people_json", "role")}
   
   
     -- CLIENT
     ${arrayToJsonSqlQuery(userSelection.client, "hca_agent_operation_json", "client")}
   
     -- QUEUE
     ${arrayToJsonSqlQuery(userSelection.queue, "hca_agent_operation_json", "queue")}
   
     -- SERVICE
     ${arrayToJsonSqlQuery(userSelection.service, "hca_agent_operation_json", "service")}
   
     -- CAMPAIGN
     ${arrayToJsonSqlQuery(
    userSelection.campaign,
    "hca_agent_operation_json",
    "campaign"
  )}

GROUP BY 
    hca_agent_id


`;
 
}

function auditConecctionQuery(userSelection) {
  return `
-- ---------------------------------------------------------------
-- FIELDS
SELECT

-- TIME & INTERVAL

audit_agent_id
,DATE(audit_datetime_init) as login_start_date
,count(audit_agent_id) AS COUNT_audit_agent_id
,IF(audit_datetime_end is null, SUM(TIMESTAMPDIFF(second,audit_datetime_init,now())), SUM(audit_duration_sec)) as login_duration_sec
,SEC_TO_TIME(IF(audit_datetime_end is null, SUM(TIMESTAMPDIFF(second,audit_datetime_init,now())), SUM(audit_duration_sec))) as login_duration_time


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

-- SUPERVISOR
${objectToJsonSqlQuery(
    userSelection.supervisor,
    "audit_people_json",
    "supervisor"
  )}

-- SCHEDULE
${objectToJsonSqlQuery(userSelection.client, "audit_time_json", "schedule")}

-- ROLE
${objectToJsonSqlQuery(userSelection.client, "audit_people_json", "role")}


-- CLIENT
${arrayToJsonSqlQuery(userSelection.client, "audit_operation_json", "client")}

-- QUEUE
${arrayToJsonSqlQuery(userSelection.queue, "audit_operation_json", "queue")}

-- SERVICE
${arrayToJsonSqlQuery(userSelection.service, "audit_operation_json", "service")}

-- CAMPAIGN
${arrayToJsonSqlQuery(
    userSelection.campaign,
    "audit_operation_json",
    "campaign"
  )}

-- BREAK
${arrayToSqlQuery(userSelection.auxiliar, "audit_break_id")}

-- ASIGNACION
${arrayToSqlQuery(userSelection.assignation, "audit_break_id")}


GROUP BY audit_agent_id

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

audit_agent_id
,DATE(audit_datetime_init) as auxiliar_start_date
,count(audit_agent_id) AS COUNT_audit_agent_id
,IF(audit_datetime_end is null, TIMESTAMPDIFF(second,audit_datetime_init,now()), SUM(audit_duration_sec)) as auxiliar_duration_sec
,SEC_TO_TIME(IF(audit_datetime_end is null, TIMESTAMPDIFF(second,audit_datetime_init,now()), SUM(audit_duration_sec))) as auxiliar_duration_time


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

-- SUPERVISOR
${objectToJsonSqlQuery(
    userSelection.supervisor,
    "audit_people_json",
    "supervisor"
  )}

-- SCHEDULE
${objectToJsonSqlQuery(userSelection.client, "audit_time_json", "schedule")}

-- ROLE
${objectToJsonSqlQuery(userSelection.client, "audit_people_json", "role")}


-- CLIENT
${arrayToJsonSqlQuery(userSelection.client, "audit_operation_json", "client")}

-- QUEUE
${arrayToJsonSqlQuery(userSelection.queue, "audit_operation_json", "queue")}

-- SERVICE
${arrayToJsonSqlQuery(userSelection.service, "audit_operation_json", "service")}

-- CAMPAIGN
${arrayToJsonSqlQuery(
    userSelection.campaign,
    "audit_operation_json",
    "campaign"
  )}

-- BREAK
${arrayToSqlQuery(userSelection.auxiliar, "audit_break_id")}

-- ASIGNACION
${arrayToSqlQuery(userSelection.assignation, "audit_break_id")}


GROUP BY audit_agent_id

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

audit_agent_id
,DATE(audit_datetime_init) as assignation_start_date
,count(audit_agent_id) AS COUNT_audit_agent_id
,IF(audit_datetime_end is null, TIMESTAMPDIFF(second,audit_datetime_init,now()), SUM(audit_duration_sec)) as assignation_duration_sec
,SEC_TO_TIME(IF(audit_datetime_end is null, TIMESTAMPDIFF(second,audit_datetime_init,now()), SUM(audit_duration_sec))) as assignation_duration_time


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

-- SUPERVISOR
${objectToJsonSqlQuery(
    userSelection.supervisor,
    "audit_people_json",
    "supervisor"
  )}

-- SCHEDULE
${objectToJsonSqlQuery(userSelection.client, "audit_time_json", "schedule")}

-- ROLE
${objectToJsonSqlQuery(userSelection.client, "audit_people_json", "role")}


-- CLIENT
${arrayToJsonSqlQuery(userSelection.client, "audit_operation_json", "client")}

-- QUEUE
${arrayToJsonSqlQuery(userSelection.queue, "audit_operation_json", "queue")}

-- SERVICE
${arrayToJsonSqlQuery(userSelection.service, "audit_operation_json", "service")}

-- CAMPAIGN
${arrayToJsonSqlQuery(
    userSelection.campaign,
    "audit_operation_json",
    "campaign"
  )}

-- BREAK
${arrayToSqlQuery(userSelection.auxiliar, "audit_break_id")}

-- ASIGNACION
${arrayToSqlQuery(userSelection.assignation, "audit_break_id")}


GROUP BY audit_agent_id

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


cdr_agent_id
,DATE(cdr_calldate) as outbound_start_date
,IF(cdr_call_type = 'outbound', SUM(cdr_call_made), 0) as outbound_calls_made
,IF(cdr_call_type = 'outbound', SUM(cdr_duration_sec), 0) as outbound_made_sec
,IF(cdr_call_type = 'outbound', SEC_TO_TIME(SUM(cdr_duration_sec)), 0) as outbound_made_time
,IF(cdr_call_type = 'internal', SUM(cdr_call_made), 0) as outbound_internal_made
,IF(cdr_call_type = 'internal', SUM(cdr_duration_sec), 0) as outbound_internal_sec
,IF(cdr_call_type = 'internal', SEC_TO_TIME(SUM(cdr_duration_sec)), 0) as outbound_internal_time

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

-- SUPERVISOR
${objectToJsonSqlQuery(
    userSelection.supervisor,
    "cdr_people_json",
    "supervisor"
  )}

-- SCHEDULE
${objectToJsonSqlQuery(userSelection.client, "cdr_time_json", "schedule")}

-- ROLE
${objectToJsonSqlQuery(userSelection.client, "cdr_people_json", "role")}

-- CLIENT
${arrayToJsonSqlQuery(userSelection.client, "cdr_operation_json", "client")}

-- QUEUE
${arrayToSqlQuery(userSelection.queue, "cdr_queue_id")}

-- SERVICE
${arrayToJsonSqlQuery(userSelection.service, "cdr_operation_json", "service")}

-- CAMPAIGN
${arrayToSqlQuery(userSelection.campaign, "callentry_campaign_id")}


GROUP BY cdr_agent_id

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

callentry_agent_id
,DATE(callentry_datetime_init) as inbound_start_date
,count(callentry_agent_id) AS COUNT_callentry_agent_id
,JSON_UNQUOTE(JSON_EXTRACT(callentry_people_json, "$[0].name")) as supervisor_name
,IF(callentry_status = 'terminada', COUNT(callentry_id), 0) as inbound_calls_attended
,IF(callentry_status = 'terminada', SUM(callentry_duration_sec), 0) as inbound_attended_duration_sec
,IF(callentry_status = 'terminada', SEC_TO_TIME(SUM(callentry_duration_sec)), 0) as inbound_attended_duration_time



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

-- SUPERVISOR
${objectToJsonSqlQuery(
    userSelection.supervisor,
    "callentry_people_json",
    "supervisor"
  )}

-- SCHEDULE
${objectToJsonSqlQuery(userSelection.client, "callentry_time_json", "schedule")}

-- ROLE
${objectToJsonSqlQuery(userSelection.client, "callentry_people_json", "role")}

-- CLIENT
${arrayToJsonSqlQuery(
    userSelection.client,
    "callentry_operation_json",
    "client"
  )}

-- QUEUE
${arrayToSqlQuery(userSelection.queue, "callentry_queue_id")}

-- SERVICE
${arrayToJsonSqlQuery(
    userSelection.service,
    "callentry_operation_json",
    "service"
  )}

-- CAMPAIGN
${arrayToSqlQuery(userSelection.campaign, "callentry_campaign_id")}

GROUP BY callentry_agent_id

-- ---------------------------------------------------------------
-- END
 `;
}
