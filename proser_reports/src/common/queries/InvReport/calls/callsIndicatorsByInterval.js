import * as pool from "../../../../connectors/pool";

// import userSelectionFilters from "../../InvMenu/userSelection/userSelectionFilters";

import {
  dateAndTimeSqlQuery,
  arrayToSqlQuery,
  objectToJsonSqlQuery,
  arrayToJsonSqlQuery,
  sqlIntervalSqlQuery,
  sqlIntervalGroupSqlQuery,
  sqlIntervalGroupSqlQueryToIndicators
} from "../../../functions/sqlFunctions";

/******************************************************************** */

export async function callsIndicatorsByIntervalReport(userSelection) {
  // DEFINE VARIABLES
  let result = {
    detail: [],
    subtotal: [],
    total: []
  };

  /* DETAIL ********************************* */
  let queryDetail = query(userSelection);
  
  try {
    result.detail = await pool.destinyReports.query(queryDetail);
  } catch (error) {
    result.detail = { errorDetail: error };
  }

  /* SUBTOTAL ********************************* */
  let querySubtotal= `
  
  SELECT
    
      now() AS now
    ,'' as day_name
    ,'' as week_day
    ,daily.start_date AS start_date
    ,'SUBTOTAL' AS interval_start
    ,'' AS end_time
    ,SUM(inboundReceived) AS inboundReceived
    ,SUM(inboundAttended) AS inboundAttended
    ,SUM(inboundBeforeTime) AS inboundBeforeTime
    ,SUM(inboundBeforeMinute) AS inboundBeforeMinute
    ,SUM(inboundBeforeTime)/SUM(inboundReceived) AS inboundServiceLevel
    ,SUM(inboundBeforeMinute)/SUM(inboundReceived) AS inboundServiceLevelMinute
    ,SUM(inboundAttended)/SUM(inboundReceived) AS inboundAttentionLevel
    ,SUM(operationSeconds)/SUM(inboundAttended) AS inboundTmo
    ,SUM(waitTimeAttended)/SUM(inboundAttended) AS avgWaitTimeAnswer
    ,SUM(waitTimeAbandoned)/SUM(inboundAbandoned) AS avgWaitTimeAbandon
    ,MAX(maxWaitTimeAnswer) as maxWaitTimeAnswer
    ,MAX(maxWaitTimeAbandon) as maxWaitTimeAbandon
    ,SUM(inboundAbandoned) AS inboundAbandoned
    ,SUM(inboundAbandoned)/SUM(inboundReceived) AS inboundAbandonLevel

    FROM
        (
          
          ${query(userSelection)}  ) AS daily

    GROUP BY
      start_date
    
    `;
  
  try {
    result.subtotal = await pool.destinyReports.query(querySubtotal);
  } catch (error) {
    result.subtotal = { errorDetail: error };
  }


  /* TOTAL ********************************* */
  let queryTotal = `
    SELECT
      now() AS now
    ,'' as day_name
    ,'' as week_day
    ,'' AS start_date
    ,'TOTAL GENERAL' AS interval_start
    ,'' AS start_time
    ,'' AS end_time
    ,SUM(inboundReceived) AS inboundReceived
    ,SUM(inboundAttended) AS inboundAttended
    ,SUM(inboundBeforeTime) AS inboundBeforeTime
    ,SUM(inboundBeforeMinute) AS inboundBeforeMinute
    ,SUM(inboundBeforeTime)/SUM(inboundReceived) AS inboundServiceLevel
    ,SUM(inboundBeforeMinute)/SUM(inboundReceived) AS inboundServiceLevelMinute
    ,SUM(inboundAttended)/SUM(inboundReceived) AS inboundAttentionLevel
    ,SUM(operationSeconds)/SUM(inboundAttended) AS inboundTmo
    ,SUM(waitTimeAttended)/SUM(inboundAttended) AS avgWaitTimeAnswer
    ,SUM(waitTimeAbandoned)/SUM(inboundAbandoned) AS avgWaitTimeAbandon
    ,MAX(maxWaitTimeAnswer) as maxWaitTimeAnswer
    ,MAX(maxWaitTimeAbandon) as maxWaitTimeAbandon
    ,SUM(inboundAbandoned) AS inboundAbandoned
    ,SUM(inboundAbandoned)/SUM(inboundReceived) AS inboundAbandonLevel

    FROM
        (
          
          ${query(userSelection)}  ) AS daily
    
    `;

  try {
    result.total = await pool.destinyReports.query(queryTotal);
  } catch (error) {
    result.total = { errorTotal: error };
  }

  return result;
}

// MAIN QUERY
function query(userSelection) {
  return `

-- ---------------------------------------------------------------
-- FIELDS
SELECT

-- TIME & INTERVAL

now() AS now
,${sqlIntervalSqlQuery(userSelection, "callentry_datetime_entry_queue")}

  ,DAYNAME(callentry_date) as day_name
  ,WEEKDAY(callentry_date) + ${process.env.MONDAY_CONFIG} as week_day

  ,DATE_FORMAT(callentry_date, "%Y-%m-%d") AS start_date
  
  ,MIN(DATE_FORMAT(callentry_datetime_init, '%H:%i:%s')) AS start_time
  
  ,MAX(DATE_FORMAT(callentry_datetime_end, '%H:%i:%s')) AS end_time
  
  ,SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundReceived
  
  ,SUM(case when callentry_status = 'terminada' then 1 else 0 end) AS inboundAttended

  ,SUM(case when (callentry_duration_sec_wait <= ${process.env.CDR_SERVICE_IDEAL_TIME} AND callentry_status = 'terminada')then 1 else 0 end) AS inboundBeforeTime

  ,SUM(case when (callentry_duration_sec_wait <= 59.9 AND callentry_status = 'terminada')then 1 else 0 end) AS inboundBeforeMinute

  ,SUM(case when (callentry_status = 'terminada' AND callentry_duration_sec_wait <= ${process.env.CDR_SERVICE_IDEAL_TIME}) then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundServiceLevel

   ,SUM(case when (callentry_status = 'terminada' AND callentry_duration_sec_wait <= 59.9) then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundServiceLevelMinute

   ,SUM(case when callentry_status = 'terminada' then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundAttentionLevel

   ,SUM(case when callentry_status = 'terminada' then callentry_duration_sec else 0 end)/
   SUM(case when callentry_status = 'terminada' then 1 else 0 end) AS inboundTmo

   ,SUM(IF(callentry_status = 'terminada', callentry_duration_sec_wait, 0))/
   SUM(case when callentry_status = 'terminada' then 1 else 0 end) AS avgWaitTimeAnswer

   ,SUM(IF(callentry_status = 'abandonada', callentry_duration_sec_wait, 0))/
   SUM(case when callentry_status = 'abandonada' then 1 else 0 end) AS avgWaitTimeAbandon

   ,MAX(IF(callentry_status = 'terminada', callentry_duration_sec_wait, 0)) as maxWaitTimeAnswer

   ,MAX(IF(callentry_status = 'abandonada', callentry_duration_sec_wait, 0)) as maxWaitTimeAbandon

   ,SUM(case when callentry_status = 'abandonada' then 1 else 0 end) AS inboundAbandoned

   ,SUM(case when callentry_status = 'abandonada' then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundAbandonLevel

   ,SUM(case when callentry_status = 'terminada' then callentry_duration_sec else 0 end) AS operationSeconds
   
   ,SUM(IF(callentry_status = 'terminada', callentry_duration_sec_wait, 0)) AS waitTimeAttended

   ,SUM(IF(callentry_status = 'abandonada', callentry_duration_sec_wait, 0)) AS waitTimeAbandoned

 -- ---------------------------------------------------------------
 -- TABLES & JOINS
 FROM

 MainCallEntry
 
 LEFT OUTER JOIN InvAgent
 ON callentry_agent_id = inv_agent_id
  
 LEFT OUTER JOIN InvQueue
 ON callentry_queue_id = inv_queue_id
 
 -- -----------------------------
 WHERE 1
 
 AND
 inv_queue_type = 'inbound'
 
 -- TIME AND DATE
 ${dateAndTimeSqlQuery(userSelection, "callentry_datetime_entry_queue")}
 AND callentry_date is not null
 
 -- AGENT
 ${arrayToSqlQuery(userSelection.agent, "callentry_agent_id")}
 
 -- SUPERVISOR
${objectToJsonSqlQuery(userSelection.supervisor, "callentry_people_json", "supervisor")}

-- SCHEDULE
${objectToJsonSqlQuery(userSelection.client, "callentry_time_json", "schedule")}

-- ROLE
${objectToJsonSqlQuery(userSelection.client, "callentry_people_json", "role")}

-- CLIENT
${arrayToJsonSqlQuery(userSelection.client, "callentry_operation_json", "client")}

-- QUEUE
${arrayToSqlQuery(userSelection.queue, "callentry_queue_id")}

-- SERVICE
${arrayToJsonSqlQuery(userSelection.service, "callentry_operation_json", "service")}
 
 -- CAMPAIGN
 ${arrayToSqlQuery(userSelection.campaign, "callentry_campaign_id")}

 GROUP BY
 
start_date
${sqlIntervalGroupSqlQueryToIndicators(userSelection)}


-- ---------------------------------------------------------------
-- END
`;
}
