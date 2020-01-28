import * as pool from "../../../../connectors/pool";
import moment from "moment";
// import userSelectionFilters from "../../InvMenu/userSelection/userSelectionFilters";

import {
  dateAndTimeSqlQuery,
  dateAndTimeSqlQueryRealTime
} from "../../../functions/sqlFunctions";

/******************************************************************** */

export async function displayMonitorByCalls(userSelection) {
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
    result.detail = await pool.destinyReports.query(queryDetail);
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
    result.total = await pool.destinyReports.query(queryTotal);
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
  ,idealResponseTime
  ,'' as queueName
  ,'' as queueNumber
  ,MAX(maxWaitTime) as maxWaitTime
  ,MAX(maxWaitTimeAnswer) as maxWaitTimeAnswer
  ,MAX(maxWaitTimeAbandon) as maxWaitTimeAbandon
  ,SUM(inboundReceived) AS inboundReceived
  ,SUM(inboundAttended) AS inboundAttended
  ,SUM(inboundAbandoned) AS inboundAbandoned
  ,SUM(inboundBeforeTime) AS inboundBeforeTime
  ,SUM(inboundBeforeMinute) AS inboundBeforeMinute
  ,SUM(inboundShort) AS inboundShort
  ,SUM(inboundBeforeTime)/SUM(inboundReceived) AS inboundServiceLevel
  ,SUM(inboundAttendedLastHourBeforeTime)/SUM(inboundReceivedLastHour) AS inboundServiceLevelLastHourBeforeTime
  ,SUM(inboundBeforeMinute)/SUM(inboundReceived) AS inboundServiceLevelMinute
  ,SUM(inboundAttendedLastHourBeforeMinute)/SUM(inboundReceivedLastHour) AS inboundServiceLevelLastHourBeforeMinute
  ,SUM(inboundAttended)/SUM(inboundReceived) AS inboundAttentionLevel
  ,SUM(inboundAbandoned)/SUM(inboundReceived) AS inboundAbandonLevel
  
  `;
}

/******************************************************* */
// DETAIL FIELDS
function detailFields(userSelection) {
  
  return `
DATE(now()) as now_date
,TIME(now()) as now_time
,${process.env.CDR_SERVICE_IDEAL_TIME} AS idealResponseTime
,inv_queue_shortname as queueName
,callentry_queue_number as queueNumber
,MAX(callentry_duration_sec_wait) as maxWaitTime
,MAX(IF(callentry_status = 'terminada', callentry_duration_sec_wait, 0)) as maxWaitTimeAnswer
,MAX(IF(callentry_status = 'abandonada', callentry_duration_sec_wait, 0)) as maxWaitTimeAbandon
,SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundReceived
,SUM(case when callentry_status = 'terminada' then 1 else 0 end) AS inboundAttended
,SUM(case when callentry_status = 'abandonada' then 1 else 0 end) AS inboundAbandoned
,SUM(case when (callentry_duration_sec_wait <= ${process.env.CDR_SERVICE_IDEAL_TIME} AND callentry_status = 'terminada')then 1 else 0 end) AS inboundBeforeTime
,SUM(case when (callentry_duration_sec_wait <= 59.9 AND callentry_status = 'terminada')then 1 else 0 end) AS inboundBeforeMinute
,SUM(case when callentry_duration_sec <= ${process.env.CDR_SHORTCALL_TIME} then 1 else 0 end) AS inboundShort
,SUM(case when (callentry_status = 'terminada' OR callentry_status = 'abandonada') AND (callentry_datetime_init >= (TIMEDIFF(TIME(now()), SEC_TO_TIME(3600)))) then 1 else 0 end) as inboundReceivedLastHour
,SUM(case when (callentry_status = 'terminada' ) AND (callentry_duration_sec_wait <= ${process.env.CDR_SERVICE_IDEAL_TIME}) AND (callentry_datetime_init >= (TIMEDIFF(TIME(now()), SEC_TO_TIME(3600)))) then 1 else 0 end) as inboundAttendedLastHourBeforeTime
,SUM(case when (callentry_status = 'terminada' ) AND (callentry_duration_sec_wait <= 59.9) AND (callentry_datetime_init >= (TIMEDIFF(TIME(now()), SEC_TO_TIME(3600)))) then 1 else 0 end) as inboundAttendedLastHourBeforeMinute
,SUM(case when (callentry_status = 'terminada' AND callentry_duration_sec_wait <= ${process.env.CDR_SERVICE_IDEAL_TIME}) then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundServiceLevel
,SUM(case when (callentry_status = 'terminada') AND (callentry_duration_sec_wait <= ${process.env.CDR_SERVICE_IDEAL_TIME}) AND (callentry_datetime_init >= (TIMEDIFF(TIME(now()), SEC_TO_TIME(3600)))) then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' ) AND (callentry_datetime_init >= (TIMEDIFF(TIME(now()), SEC_TO_TIME(3600)))) then 1 else 0 end) AS inboundServiceLevelLastHourBeforeTime
,SUM(case when (callentry_status = 'terminada' AND callentry_duration_sec_wait <= 59.9) then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundServiceLevelMinute
,SUM(case when (callentry_status = 'terminada') AND (callentry_duration_sec_wait <= 59.9) AND (callentry_datetime_init >= (TIMEDIFF(TIME(now()), SEC_TO_TIME(3600)))) then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' ) AND (callentry_datetime_init >= (TIMEDIFF(TIME(now()), SEC_TO_TIME(3600)))) then 1 else 0 end) AS inboundServiceLevelLastHourBeforeMinute
,SUM(case when callentry_status = 'terminada' then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundAttentionLevel
,SUM(case when callentry_status = 'abandonada' then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundAbandonLevel

  `;
}

/********************************************************* */
// MAIN QUERY
function query(userSelection) {
 
  return `

  RealCallEntry

  LEFT OUTER JOIN InvAgent
  ON callentry_agent_id = inv_agent_id
  
  LEFT OUTER JOIN InvQueue
  ON callentry_queue_id = inv_queue_id


-- -----------------------------
WHERE 1

AND
inv_queue_type = 'inbound'

-- TIME AND DATE
${dateAndTimeSqlQueryRealTime(userSelection, "callentry_datetime_entry_queue")}
AND callentry_date is not null


GROUP BY inv_queue_name


-- ---------------------------------------------------------------
-- END
`;
}
