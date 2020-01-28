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

export async function displayMonitorByIndicators(userSelection) {
  // DEFINE VARIABLES
  let result = {
    now: moment().format('YYYY-MM-DD hh:mm:ss'),
    total: [],
    detail: []
  };

  if(userSelection.mode.name='Actual'){
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
  let group_name = userSelection.groupBy.name;

  return `
  DATE(now()) as now_date
  ,TIME(now()) as now_time
  ,'TOTAL' as queueName
  
  ,'' as day_name
  ,'' as week_day

  ,'' AS start_date
  ,'' AS start_time
  ,'' AS end_time

   ,${process.env.CDR_SERVICE_IDEAL_TIME} AS idealResponseTime

  ,SUM(inboundReceived) AS inboundReceived

  ,SUM(inboundAbandoned) AS inboundAbandoned

  ,SUM(inboundAttended) AS inboundAttended

  ,SUM(inboundShort) AS inboundShort

  ,SUM(inboundBeforeTime) AS inboundBeforeTime

  ,SUM(inboundAfterTime) AS inboundAfterTime

  ,SUM(inboundHungAgent) AS inboundHungAgent

  ,SUM(inboundBeforeTime)/SUM(inboundReceived) AS inboundServiceLevel

  ,SUM(inboundAttended)/SUM(inboundReceived) AS inboundAttentionLevel

  ,SUM(inboundAbandoned)/SUM(inboundReceived) AS inboundAbandonLevel

  ,SUM(operation_seconds) AS operation_seconds

  ,SEC_TO_TIME(SUM(operation_seconds)) AS operation_time

  ,SUM(wait_seconds) AS wait_seconds

  ,SEC_TO_TIME(SUM(wait_seconds)) AS wait_time

  ,SUM(operation_seconds)/SUM(inboundAttended) AS inboundTmo

  ,SUM(wait_time_recieve)/SUM(inboundAttended) AS inboundAsa
  
  `;
}

/******************************************************* */
// DETAIL FIELDS
function detailFields(userSelection) {
  
  return `
  DATE(now()) as now_date
  ,TIME(now()) as now_time

  ,inv_queue_shortname as queueName
  
  ,DAYNAME(callentry_date) as day_name
  ,WEEKDAY(callentry_date) + ${process.env.MONDAY_CONFIG} as week_day

  ,DATE_FORMAT(callentry_date, "%Y-%m-%d") AS start_date
  
  ,MIN(DATE_FORMAT(callentry_datetime_init, '%H:%i:%s')) AS start_time
  
  ,MAX(DATE_FORMAT(callentry_datetime_end, '%H:%i:%s')) AS end_time
  
  ,${process.env.CDR_SERVICE_IDEAL_TIME} AS idealResponseTime
  ,${process.env.CDR_SHORTCALL_TIME} AS shortTimeDef
  
  ,SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundReceived
  
  ,SUM(case when callentry_status = 'abandonada' then 1 else 0 end) AS inboundAbandoned
  
  ,SUM(case when callentry_status = 'terminada' then 1 else 0 end) AS inboundAttended
  
  ,SUM(case when callentry_duration_sec <= ${process.env.CDR_SHORTCALL_TIME} then 1 else 0 end) AS inboundShort
  
  ,SUM(case when (callentry_duration_sec_wait <= ${process.env.CDR_SERVICE_IDEAL_TIME} AND callentry_status = 'terminada')then 1 else 0 end) AS inboundBeforeTime

  ,SUM(case when callentry_status = 'terminada' then 1 else 0 end) - SUM(case when (callentry_duration_sec_wait <= ${process.env.CDR_SERVICE_IDEAL_TIME} AND callentry_status = 'terminada')then 1 else 0 end) AS inboundAfterTime
  
  ,SUM(callentry_hung_agent) AS inboundHungAgent
  
  ,SUM(case when (callentry_status = 'terminada' AND callentry_duration_sec_wait <= ${process.env.CDR_SERVICE_IDEAL_TIME}) then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundServiceLevel
  
  ,SUM(case when callentry_status = 'terminada' then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundAttentionLevel
  
  ,SUM(case when callentry_status = 'abandonada' then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundAbandonLevel
  
  ,SUM(callentry_duration_sec) AS operation_seconds
  
  ,SEC_TO_TIME(SUM(callentry_duration_sec)) AS operation_time
  
  ,SUM(callentry_duration_sec_wait) AS wait_seconds
  
  ,SEC_TO_TIME(SUM(callentry_duration_sec_wait)) AS wait_time
  
  ,SUM(case when callentry_status = 'terminada' then callentry_duration_sec else 0 end)/
   SUM(case when callentry_status = 'terminada' then 1 else 0 end) AS inboundTmo
  
  ,SUM(case when callentry_status = 'terminada' then callentry_duration_sec_wait else 0 end)/
   SUM(case when callentry_status = 'terminada' then 1 else 0 end) AS inboundAsa

  ,SUM(case when callentry_status = 'terminada' then callentry_duration_sec_wait else 0 end) as wait_time_recieve

  `;
}

/********************************************************* */
// MAIN QUERY
function query(userSelection) {
 
  return `

RealCallEntry

LEFT OUTER JOIN InvAgent as AGENT
ON callentry_agent_id = inv_agent_id

LEFT OUTER JOIN InvQueue as QUEUE
ON callentry_queue_id = inv_queue_id

-- -----------------------------
WHERE 1

AND
QUEUE.inv_queue_type = 'inbound'

-- TIME AND DATE
${dateAndTimeSqlQueryRealTime(userSelection, "callentry_datetime_entry_queue")}
AND callentry_date is not null


GROUP BY inv_queue_name


-- ---------------------------------------------------------------
-- END
`;
}
