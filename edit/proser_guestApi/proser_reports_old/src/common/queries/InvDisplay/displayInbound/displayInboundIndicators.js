// DISPLAY INBOUND REPORT
/**********************************
 * Tip vscode:
 * ctrl+k & ctrl+0 to view collapsed - ctrl+k & ctrl+j to expand
 */

// IMPORTS
import * as pool from "../../../../connectors/pool";
import { removeRowDataPacket } from "../../../../helpers/mysql-helper.js";
import {
  objectDateToTextDate,
  valueFromObject
} from "../../../functions/dateFunctions";

import {
  dateAndTimeSqlQuery,
  dateAndTimeSqlQueryRealTime,
  arrayToSqlQuery,
  objectToJsonSqlQuery,
  arrayToJsonSqlQuery,
  sqlIntervalSqlQuery,
  sqlIntervalGroupSqlQuery
} from "../../../functions/sqlFunctions";

import {
  onColorForPercentage,
  onColorForCallsOnQueue
} from "../../../functions/scaleFunctions";

import { userSelectionBlank } from "../../../functions/userSelectionFunctions.js";
import moment from "moment";

/******************************************************************** */
// MAIN FUNCTION
export async function displayInboundIndicators(userSelectionIn) {
  let result = {};
  let resume_error = false;

  let userSelection = await proShowSelection(userSelectionIn, "inbound");

  if(userSelection.mode.name='Actual'){
    userSelection.start_date = userSelection.current_date;
    userSelection.end_date = userSelection.end_date;
  }

  // console.log("userSelection from database", userSelection);

  let displayInboundCallsIndicators = await displayInboundCallsIndicatorsFunction(
    userSelection
  );
  let displayInboundCurrentCallsIndicators = await displayInboundCurrentCallsIndicatorsFunction(
    userSelection
  );
  let agentsPlannedTotal = await agentsPlannedTotalFunction(userSelection);
  let agentsConnectedTotal = await agentsConnectedTotalFunction(userSelection);
  let agentsLoggedTotal = await agentsLoggedTotalFunction(userSelection);
  let agentsConnectedByGroup = await agentsConnectedByGroupFunction(
    userSelection
  );

  let agentHistoricResume = []//await agentHistoricResumeFunction(userSelection);

  let agentsAuxiliarResume = await agentsAuxiliarResumeFunction(userSelection);
  let agentsAssignationResume = await agentsAssignationResumeFunction(
    userSelection
  );
  let agentsHistoricBreakResume = [] //await agentsHistoricBreakResumeFunction(userSelection);
  let agentsHistoricAssignationResume = [] // await agentsHistoricAssignationResumeFunction(userSelection);

  let scale = await scaleFunction(userSelection);

  let colors = [
    {
      inboundServiceLevel: onColorForPercentage(
        displayInboundCallsIndicators[0].inboundServiceLevel,
        scale[0]
      ),
      inboundAttentionLevel: onColorForPercentage(
        displayInboundCallsIndicators[0].inboundAttentionLevel,
        scale[0]
      ),
      inboundAbandonLevel: onColorForPercentage(
        displayInboundCallsIndicators[0].inboundAbandonLevel,
        scale[0]
      ),
      callsOnQueue: onColorForCallsOnQueue(
        displayInboundCurrentCallsIndicators[0].maxWaitTimeOnQue,
        parseInt(process.env.CDR_SERVICE_IDEAL_TIME)
      ),
      callsOnQueueWaitTime:
        displayInboundCurrentCallsIndicators[0].maxWaitTimeOnQue,
      callsOnQueueIdeal: parseInt(process.env.CDR_SERVICE_IDEAL_TIME)
    }
  ];

  result = {
    displayInboundCallsIndicators,
    displayInboundCurrentCallsIndicators,
    agentsPlannedTotal,
    agentsConnectedTotal,
    agentsLoggedTotal,
    agentsConnectedByGroup,
    agentHistoricResume,
    agentsAuxiliarResume,
    agentsAssignationResume,
    agentsHistoricBreakResume,
    agentsHistoricAssignationResume,
    scale,
    colors,
    userSelection
  };

  return result;
}

/**************************************** */
// pro-show-selection

async function proShowSelection(userSelection, type) {
  let current_time = moment().format("HH:mm:ss");
  let current_date = moment().format("YYYY-MM-DD");
  let current_year = moment().format("YYYY");
  let current_month = moment().format("M");
  let current_day = moment().format("D");

  let query = `
  SELECT
  pro_show_display_selection as selection
  FROM
  ProShowDisplay
  WHERE
  JSON_UNQUOTE(JSON_EXTRACT(pro_show_display_type, "$.value"))= '${type}'
  AND
  pro_show_display_start_time <= '${current_time}'
  AND
  pro_show_display_end_time >= '${current_time}'

  ORDER BY pro_show_display_start_time DESC

  limit 1
  `;
  // console.log("query", query);

  // let query = `
  // SELECT pro_show_display_selection FROM proser_base_new.ProShowDisplay Limit 1
  // `;

  try {
    let result = userSelection;
    let temp, temp2, temp3;

    temp = await pool.destiny.query(query);

    if (!temp.length == 0) {
      temp2 = removeRowDataPacket(temp);
      // console.log("temp", temp2);

      temp3 = JSON.parse(temp2[0].selection);

      // temp3.options = "Opciones";
      // temp3.legend = "";
      temp3.start_date = { year: 2019, month: 10, day: 9 };
      temp3.end_date = { year: 2019, month: 10, day: 9 };

      temp3.title = "Llamadas entrantes";
      temp3.entity_selection = "Automatic display";
      temp3.mode = { id: 0, name: "Actual" };

      temp3.start_date = {
        year: +current_year,
        month: +current_month,
        day: +current_day
      };
      temp3.end_date = {
        year: +current_year,
        month: +current_month,
        day: +current_day
      };

      temp3.creation_date = current_date;
      temp3.creation_time = current_time;
      // console.log("temp", temp3);
      return temp3;
    } else {
      return userSelection;
    }
  } catch (error) {
    let result = userSelection;
    return result;
  }
}

/**************************************** */
// indicators
async function displayInboundCallsIndicatorsFunction(userSelection) {
  let result = null;
  let resume_error = false;
  // ,SUM(case when callentry_duration_sec_wait <= ${
  //   process.env.CDR_SERVICE_IDEAL_TIME
  // } then 1 else 0 end)/
  //  SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundServiceLevel

  let query = `

  -- displayInboundCallsIndicatorsFunction --------------------
  -- FIELDS
  SELECT
  
  -- TIME & INTERVAL
  
  now() AS now
  ,DAYNAME(callentry_date) as day_name
  ,WEEKDAY(callentry_date) + ${process.env.MONDAY_CONFIG} as week_day
      
  ,'${objectDateToTextDate(userSelection.current_date)}' AS start_date
  ,'${objectDateToTextDate(userSelection.current_date)}' AS end_date

  ,'${valueFromObject(userSelection.start_time, "00:00:00")}' AS start_time
  ,'${valueFromObject(userSelection.end_time, "24:00:00")}' AS end_time
  
  ,MIN(DATE_FORMAT(callentry_datetime_init, '%H:%i:%s')) AS min_start_time
  ,MAX(DATE_FORMAT(callentry_datetime_end, '%H:%i:%s')) AS max_end_time
  
  ,${process.env.CDR_SERVICE_IDEAL_TIME} AS idealResponseTime
  ,${process.env.CDR_SHORTCALL_TIME} AS shortTimeDef

  ,MAX(callentry_duration_sec_wait) as maxWaitTime
  
  ,SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundReceived
  
  ,SUM(case when callentry_status = 'abandonada' then 1 else 0 end) AS inboundAbandoned
  
  ,SUM(case when callentry_status = 'terminada' then 1 else 0 end) AS inboundAttended
  
  ,SUM(case when callentry_duration_sec <= ${
  process.env.CDR_SHORTCALL_TIME
} then 1 else 0 end) AS inboundShort
  
  ,SUM(case when (callentry_duration_sec_wait <= ${
  process.env.CDR_SERVICE_IDEAL_TIME
} AND callentry_status = 'terminada')then 1 else 0 end) AS inboundBeforeTime
  
  ,SUM(case when callentry_status = 'terminada' then 1 else 0 end) - SUM(case when (callentry_duration_sec_wait <= ${
  process.env.CDR_SERVICE_IDEAL_TIME
} AND callentry_status = 'terminada')then 1 else 0 end) AS inboundAfterTime
  
  ,SUM(callentry_hung_agent) AS inboundHungAgent
  
  ,SUM(case when (callentry_status = 'terminada' AND callentry_duration_sec_wait <= ${
  process.env.CDR_SERVICE_IDEAL_TIME
} ) then 1 else 0 end) / SUM( case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' ) then 1 else 0 end) AS inboundServiceLevel

  
  ,SUM(case when callentry_status = 'terminada' then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundAttentionLevel
  
  ,SUM(case when callentry_status = 'abandonada' then 1 else 0 end)/
   SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS inboundAbandonLevel
  
  ,SUM(callentry_duration_sec) AS operation_seconds
  
  ,SEC_TO_TIME(SUM(callentry_duration_sec)) AS operation_time
  
  ,SUM(callentry_duration_sec_wait) AS wait_seconds
  
  ,SEC_TO_TIME(SUM(callentry_duration_sec_wait)) AS wait_time

  ,MAX(callentry_duration_sec_wait) as maxWaitTime
  
  ,SUM(case when callentry_status = 'terminada' then callentry_duration_sec else 0 end)/
   SUM(case when callentry_status = 'terminada' then 1 else 0 end) AS inboundTmo
  
  ,SUM(case when callentry_status = 'terminada' then callentry_duration_sec_wait else 0 end)/
   SUM(case when callentry_status = 'terminada' then 1 else 0 end) AS inboundAsa
  
   -- ---------------------------------------------------------------
   -- TABLES & JOINS
   FROM
   
   RealCallEntry
   
   LEFT OUTER JOIN InvAgent
   ON callentry_agent_id = inv_agent_id
  
    
   LEFT OUTER JOIN InvQueue
   ON callentry_queue_id = inv_queue_id
   
   
   -- -----------------------------
   WHERE 1
   
   
   -- TIME AND DATE
   ${dateAndTimeSqlQueryRealTime(
    userSelection,
    "callentry_datetime_entry_queue"
  )}
      
   -- AGENT
   ${arrayToSqlQuery(userSelection.agent, "callentry_agent_id")}
   
   -- SUPERVISOR
  ${objectToJsonSqlQuery(
    userSelection.supervisor,
    "callentry_people_json",
    "supervisor"
  )}

  -- SCHEDULE
  ${objectToJsonSqlQuery(
    userSelection.client,
    "callentry_time_json",
    "schedule"
  )}

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
   
   -- BREAK
   ${arrayToSqlQuery(userSelection.auxiliar, "audit_break_id")}
   
   -- ASIGNACION
   ${arrayToSqlQuery(userSelection.assignation, "audit_break_id")}
   
  
   -- END ---------------------------------------------------------------

  `;

  try {
    result = await pool.destiny.query(query);
    return result;
  } catch (error) {
    return (result = { errorDetail: error });
  }
}

/**************************************** */
// current calls
async function displayInboundCurrentCallsIndicatorsFunction(userSelection) {
  let result = null;
  let resume_error = false;
  let query = `
-- displayInboundCurrentCallsIndicatorsFunction --------------
-- FIELDS
SELECT

-- TIME & INTERVAL
now() as now

,SUM(CASE when rcc_callentry_status = 'activa' then 1 else 0 end) as callsActive
,SUM(CASE when rcc_callentry_status = 'en-cola' then 1 else 0 end) as callsOnQueue
,MAX(CASE when rcc_callentry_status = 'en-cola' then rcc_callentry_duration_wait_sec else 0 end) as maxWaitTimeOnQue
, 'blue' as color


-- ---------------------------------------------------------------
-- TABLES & JOINS

FROM

RealCurrentCalls

LEFT OUTER JOIN InvAgent
ON rcc_callentry_agent_id = inv_agent_id

LEFT OUTER JOIN InvQueue
ON rcc_callentry_queue_id = inv_queue_id


-- ---------------------------------------------------------------
-- CONDITIONS
WHERE 1

-- TIME AND DATE

-- AGENT
${arrayToSqlQuery(userSelection.agent, "inv_agent_id")}

-- SUPERVISOR
${objectToJsonSqlQuery(
    userSelection.supervisor,
    "inv_agent_people_json",
    "supervisor"
  )}

-- SCHEDULE
${objectToJsonSqlQuery(userSelection.client, "inv_agent_time_json", "schedule")}

-- ROLE
${objectToJsonSqlQuery(userSelection.client, "inv_agent_people_json", "role")}

-- CLIENT
${arrayToJsonSqlQuery(
    userSelection.client,
    "inv_agent_operation_json",
    "client"
  )}

-- QUEUE
${arrayToSqlQuery(userSelection.queue, "rcc_callentry_queue_id")}

-- SERVICE
${arrayToJsonSqlQuery(
    userSelection.service,
    "inv_agent_operation_json",
    "service"
  )}

-- CAMPAIGN
${arrayToSqlQuery(userSelection.campaign, "rcc_callentry_campaign_id")}

-- BREAK
-- ASIGNACION
-- END -------------------------------------------------------
`;

  try {
    let result = await pool.destiny.query(query);
    return result;
  } catch (error) {
    return (result = { error: error });
  }
}

/**************************************** */
// Agents planned
async function agentsPlannedTotalFunction(userSelection) {
  let result = [
    {
      now: "",
      agentsPlannedTotal: null
    }
  ];
  let resume_error = false;
  let query = `
  -- agentsPlannedTotalFunction ----------
-- FIELDS
SELECT

-- TIME & INTERVAL
   now() as now
   ,COUNT(hca_agent_id) as agentsPlannedTotal

    FROM
        RealHcaAgent
       
        -- ---------------------------------------------------------------
        -- CONDITIONS
        WHERE 1
        
        -- TIME AND DATE
        ${dateAndTimeSqlQueryRealTime(userSelection, "hca_agent_date")}
        
        -- AGENT
        ${arrayToSqlQuery(userSelection.agent, "hca_agent_id")}
        
        -- SUPERVISOR
        ${objectToJsonSqlQuery(
    userSelection.supervisor,
    "hca_agent_people_json",
    "supervisor"
  )}

        -- SCHEDULE
        ${objectToJsonSqlQuery(
    userSelection.client,
    "hca_agent_time_json",
    "schedule"
  )}

        -- ROLE
        ${objectToJsonSqlQuery(
    userSelection.client,
    "hca_agent_people_json",
    "role"
  )}

        -- CLIENT
        ${arrayToJsonSqlQuery(
    userSelection.client,
    "hca_agent_operation_json",
    "client"
  )}

        -- QUEUE
        ${arrayToJsonSqlQuery(
    userSelection.queue,
    "hca_agent_operation_json",
    "queue"
  )}

        -- SERVICE
        ${arrayToJsonSqlQuery(
    userSelection.service,
    "callentry_operation_json",
    "service"
  )}

        -- CAMPAIGN
        ${arrayToSqlQuery(userSelection.campaign, "callentry_campaign_id")}
        
        -- BREAK
        -- ASIGNACION

        GROUP BY hca_agent_date
        -- END ----------------------------------------------------------
        `;

  try {
    let temp = await pool.destiny.query(query);
    return temp.length < 1 ? result : temp;
  } catch (error) {
    return (result = { error: error });
  }
}

/**************************************** */
// Agents connected
async function agentsConnectedTotalFunction(userSelection) {
  let result = null;
  let resume_error = false;
  let query = `
  -- ---------------------------------------------------------------
  -- FIELDS
  SELECT
  
  -- TIME & INTERVAL
  now() as now
      
  ,COUNT(DISTINCT rca_agent_id) as agentsConnectedTotal
  ,SUM(CASE when rca_group_name = 'Disponible' or rca_group_name = 'Ocupado' then 1 else 0 end ) as agentsEffectiveTotal
  
  -- ---------------------------------------------------------------
  -- TABLES & JOINS
  
  FROM
  
  RealCurrentAgents
  LEFT OUTER JOIN InvAgent
  ON rca_agent_id = inv_agent_id
  
  LEFT OUTER JOIN RealAudit
  ON rca_audit_login_id = audit_id
  
  -- ---------------------------------------------------------------
  -- CONDITIONS
  WHERE 1

  AND
  rca_agent_status = 'Logueado'
  
  -- TIME AND DATE
  ${dateAndTimeSqlQueryRealTime(userSelection, "rca_agent_datetime_login")}
  
  -- AGENT
  ${arrayToSqlQuery(userSelection.agent, "rca_agent_id")}
  
  -- SUPERVISOR
  ${objectToJsonSqlQuery(
    userSelection.supervisor,
    "rca_people_json",
    "supervisor"
  )}

  -- SCHEDULE
  ${objectToJsonSqlQuery(userSelection.client, "rca_time_json", "schedule")}

  -- ROLE
  ${objectToJsonSqlQuery(userSelection.client, "rca_people_json", "role")}

  -- CLIENT
  ${arrayToJsonSqlQuery(userSelection.client, "rca_operation_json", "client")}

  -- QUEUE
  ${arrayToJsonSqlQuery(userSelection.queue, "rca_operation_json", "queue")}

  -- SERVICE
  ${arrayToJsonSqlQuery(userSelection.service, "rca_operation_json", "service")}

  -- CAMPAIGN
  ${arrayToJsonSqlQuery(
    userSelection.campaign,
    "rca_operation_json",
    "campaign"
  )}
  
  -- BREAK
  ${arrayToSqlQuery(userSelection.auxiliar, "audit_break_id")}
  
  -- ASIGNACION
  ${arrayToSqlQuery(userSelection.assignation, "audit_break_id")}
  
  
  
  -- END -----------------------------------------------------------
  `;

  try {
    let result = await pool.destiny.query(query);
    return result;
  } catch (error) {
    return (result = { error: error });
  }
}

// Agents connected
async function agentsLoggedTotalFunction(userSelection) {
  let result = null;
  let resume_error = false;
  let query = `
  -- ---------------------------------------------------------------
  -- FIELDS
  SELECT
  
  -- TIME & INTERVAL
  now() as now
      
  ,COUNT(DISTINCT audit_agent_id) as agentsLoggedTotal
  
  -- ---------------------------------------------------------------
  -- TABLES & JOINS
  
  FROM
  
  RealAudit
  LEFT OUTER JOIN InvAgent
  ON audit_agent_id = inv_agent_id
    
  -- ---------------------------------------------------------------
  -- CONDITIONS
  WHERE 1


  
  -- TIME AND DATE
  ${dateAndTimeSqlQueryRealTime(userSelection, "audit_datetime_init")}
  
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
  ${arrayToJsonSqlQuery(
    userSelection.service,
    "audit_operation_json",
    "service"
  )}

  -- CAMPAIGN
  ${arrayToJsonSqlQuery(
    userSelection.campaign,
    "audit_operation_json",
    "campaign"
  )}
  
    
  -- END ------------------------------------------------------------
  `;

  try {
    let result = await pool.destiny.query(query);
    return result;
  } catch (error) {
    return (result = { error: error });
  }
}

/**************************************** */
// agents grouped
async function agentsConnectedByGroupFunction(userSelection) {
  let result = null;
  let resume_error = false;
  let query = `
  -- ---------------------------------------------------------------
  -- FIELDS
  SELECT
  
  -- TIME & INTERVAL
  now() as now
      
  ,rca_group_name as name
  ,aux_color_string as color
  ,COUNT(DISTINCT rca_agent_id) as value
  
  -- ---------------------------------------------------------------
  -- TABLES & JOINS
  
  FROM
  
  RealCurrentAgents
  LEFT OUTER JOIN InvAgent
  ON rca_agent_id = inv_agent_id
  
  LEFT OUTER JOIN RealAudit
  ON rca_audit_login_id = audit_id

  LEFT OUTER JOIN AuxColor
  ON aux_color_use = rca_group_name
  
  -- ---------------------------------------------------------------
  -- CONDITIONS
  WHERE 1

  AND
  rca_agent_status = 'Logueado'
  
  -- TIME AND DATE
  ${dateAndTimeSqlQueryRealTime(userSelection, "rca_agent_datetime_login")}
  
  -- AGENT
  ${arrayToSqlQuery(userSelection.agent, "rca_agent_id")}
  
  -- SUPERVISOR
  ${objectToJsonSqlQuery(
    userSelection.supervisor,
    "rca_people_json",
    "supervisor"
  )}

  -- SCHEDULE
  ${objectToJsonSqlQuery(userSelection.client, "rca_time_json", "schedule")}

  -- ROLE
  ${objectToJsonSqlQuery(userSelection.client, "rca_people_json", "role")}

  -- CLIENT
  ${arrayToJsonSqlQuery(userSelection.client, "rca_operation_json", "client")}

  -- QUEUE
  ${arrayToJsonSqlQuery(userSelection.queue, "rca_operation_json", "queue")}

  -- SERVICE
  ${arrayToJsonSqlQuery(userSelection.service, "rca_operation_json", "service")}

  -- CAMPAIGN
  ${arrayToJsonSqlQuery(
    userSelection.campaign,
    "rca_operation_json",
    "campaign"
  )}
  
  -- BREAK
  ${arrayToSqlQuery(userSelection.auxiliar, "audit_break_id")}
  
  -- ASIGNACION
  ${arrayToSqlQuery(userSelection.assignation, "audit_break_id")}
  
   
  GROUP BY rca_group_name
      
  -- END ---------------------------------------------------------
  `;

  try {
    let result = await pool.destiny.query(query);
    return result;
  } catch (error) {
    return (result = { error: error });
  }
}

/**************************************** */
// agents historic
async function agentHistoricResumeFunction(userSelection) {
  let result = null;
  let resume_error = false;

  let query = `
  SET STATEMENT max_statement_time=5 FOR
  SELECT
  'planificados' as concept
  ,COUNT(DISTINCT hca_agent_id) as count_agents
  ,'0' as duration_agents
  ,'0' as average_agents
  FROM
  RealHcaAgent
  LEFT OUTER JOIN InvAgent as agent
  ON hca_agent_id = inv_agent_id
  WHERE 1
  -- TIME AND DATE
  ${dateAndTimeSqlQueryRealTime(userSelection, "hca_agent_date")}
  

  UNION


  SELECT

  'registrados' as concept
  ,COUNT(DISTINCT audit_agent_id) as count_agents
  ,SEC_TO_TIME( SUM( audit_duration_sec )) as duration_agents
  ,DATE_FORMAT(SEC_TO_TIME( SUM(audit_duration_sec) / COUNT(DISTINCT audit_agent_id)), '%H:%i:%s')
  as average_agents
  
  -- ---------------------------------------------------------------
-- TABLES & JOINS

    FROM

    RealAudit
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
      ${dateAndTimeSqlQueryRealTime(userSelection, "audit_datetime_init")}

      -- AGENT
      ${arrayToSqlQuery(userSelection.agent, "audit_agent_id")}

      -- SUPERVISOR
      ${objectToJsonSqlQuery(
    userSelection.supervisor,
    "audit_people_json",
    "supervisor"
  )}

      -- SCHEDULE
      ${objectToJsonSqlQuery(
    userSelection.client,
    "audit_time_json",
    "schedule"
  )}

      -- ROLE
      ${objectToJsonSqlQuery(userSelection.client, "audit_people_json", "role")}

      -- CLIENT
      ${arrayToJsonSqlQuery(
    userSelection.client,
    "audit_operation_json",
    "client"
  )}

      -- QUEUE
      ${arrayToJsonSqlQuery(
    userSelection.queue,
    "audit_operation_json",
    "queue"
  )}

      -- SERVICE
      ${arrayToJsonSqlQuery(
    userSelection.service,
    "audit_operation_json",
    "service"
  )}

      -- CAMPAIGN
      ${arrayToJsonSqlQuery(
    userSelection.campaign,
    "audit_operation_json",
    "campaign"
  )}
  

  UNION


  SELECT
  'Llamadas entrantes' as concept
  ,COUNT(DISTINCT callentry_agent_id) as count_agents
  ,SEC_TO_TIME(SUM((callentry_duration_sec))) as duration_agents
  ,DATE_FORMAT(SEC_TO_TIME(SUM((callentry_duration_sec)) / COUNT(DISTINCT callentry_agent_id)), '%H:%i:%s')
  as average_agents

  -- ---------------------------------------------------------------
-- TABLES & JOINS

  FROM

  RealCallEntry
  LEFT OUTER JOIN InvAgent
  ON callentry_agent_id = inv_agent_id

  LEFT OUTER JOIN InvQueue
  ON callentry_queue_id = inv_queue_id

  -- ---------------------------------------------------------------
  -- CONDITIONS
  WHERE 1


  AND
  callentry_status = 'terminada'
  
  -- TIME AND DATE
  ${dateAndTimeSqlQueryRealTime(
    userSelection,
    "callentry_datetime_entry_queue"
  )}

  -- AGENT
  ${arrayToSqlQuery(userSelection.agent, "callentry_agent_id")}

  -- SUPERVISOR
  ${objectToJsonSqlQuery(
    userSelection.supervisor,
    "callentry_people_json",
    "supervisor"
  )}

  -- SCHEDULE
  ${objectToJsonSqlQuery(
    userSelection.client,
    "callentry_time_json",
    "schedule"
  )}

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
  
  UNION

  SELECT
  'Llamadas salientes' as concept
  ,COUNT(DISTINCT cdr_agent_id) as count_agents
  ,SEC_TO_TIME(SUM((cdr_duration_sec))) as duration_agents
  ,DATE_FORMAT(SEC_TO_TIME(SUM((cdr_duration_sec)) / COUNT(DISTINCT cdr_agent_id)), '%H:%i:%s')
  as average_agents

  -- ---------------------------------------------------------------
-- TABLES & JOINS

  FROM

  RealCdr
  LEFT OUTER JOIN InvAgent
  ON cdr_agent_id = inv_agent_id

  LEFT OUTER JOIN InvQueue
  ON cdr_queue_id = inv_queue_id

  LEFT OUTER JOIN RealCallEntry
  ON cdr_uniqueid = callentry_uniqueid


  -- ---------------------------------------------------------------
  -- CONDITIONS
  WHERE 1

  AND 
  cdr_call_made = 1
  
  -- TIME AND DATE
  ${dateAndTimeSqlQueryRealTime(userSelection, "cdr_calldate")}

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

        `;

  try {
    const result = await pool.destiny.query(query);
    return result;
  } catch (error) {
    resume_error = true;
    return {
      error: "agentsIndicators - agentHistoricResumeFunction " + error
    };
  }
}

/**************************************** */
// break auxiliar resume
async function agentsAuxiliarResumeFunction(userSelection) {
  let result = null;
  let resume_error = false;
  let query = `
  -- ---------------------------------------------------------------
  -- FIELDS
  SELECT
  
  -- TIME & INTERVAL
  now() as now
  ,rcb_break_name as name
  ,rcb_break_id as id
  ,COUNT(rcb_break_audit_id) as value
  ,SEC_TO_TIME(SUM(TIME_TO_SEC(rcb_break_duration))) AS duration
  
  -- ---------------------------------------------------------------
  -- TABLES & JOINS
  
  FROM
  
  RealCurrentBreaks
  LEFT OUTER JOIN InvAgent
  ON rcb_break_agent_id = inv_agent_id
  
  LEFT OUTER JOIN InvBreak
  ON rcb_break_id = inv_break_id
    
  LEFT OUTER JOIN RealAudit
  ON rcb_break_audit_id = audit_id
  
  
  -- ---------------------------------------------------------------
  -- CONDITIONS
  WHERE 1

  AND
    rcb_break_productivity = 0
  
  -- TIME AND DATE
  ${dateAndTimeSqlQueryRealTime(userSelection, "rcb_break_datetime_init")}
  
  -- AGENT
  ${arrayToSqlQuery(userSelection.agent, "inv_agent_id")}
  
  -- SUPERVISOR
  ${objectToJsonSqlQuery(
    userSelection.supervisor,
    "rcb_people_json",
    "supervisor"
  )}

  -- SCHEDULE
  ${objectToJsonSqlQuery(userSelection.client, "rcb_time_json", "schedule")}

  -- ROLE
  ${objectToJsonSqlQuery(userSelection.client, "rcb_people_json", "role")}

  -- CLIENT
  ${arrayToJsonSqlQuery(userSelection.client, "rcb_operation_json", "client")}

  -- QUEUE
  ${arrayToJsonSqlQuery(userSelection.queue, "rcb_operation_json", "queue")}

  -- SERVICE
  ${arrayToJsonSqlQuery(userSelection.service, "rcb_operation_json", "service")}

  -- CAMPAIGN
  ${arrayToJsonSqlQuery(
    userSelection.campaign,
    "rcb_operation_json",
    "campaign"
  )}
  
  -- BREAK
  ${arrayToSqlQuery(userSelection.auxiliar, "audit_break_id")}
  
  -- ASIGNACION
  ${arrayToSqlQuery(userSelection.assignation, "audit_break_id")}
  
  
  GROUP BY rcb_break_name
  
  -- END -----------------------------------------------------------
  `;

  try {
    let result = await pool.destiny.query(query);
    return result;
  } catch (error) {
    return (result = { error: error });
  }
}

/**************************************** */
// break assignation resume
async function agentsAssignationResumeFunction(userSelection) {
  let result = null;
  let resume_error = false;
  let query = `
  -- ---------------------------------------------------------------
  -- FIELDS
  SELECT
  
  -- TIME & INTERVAL
  now() as now
  ,rcb_break_name as name
  ,rcb_break_id as id
  ,COUNT(rcb_break_audit_id) as value
  ,SEC_TO_TIME(SUM(rcb_break_duration)) AS duration
  
  -- ---------------------------------------------------------------
  -- TABLES & JOINS
  
  FROM
  
  RealCurrentBreaks
  LEFT OUTER JOIN InvAgent
  ON rcb_break_agent_id = inv_agent_id
  
  LEFT OUTER JOIN InvBreak
  ON rcb_break_id = inv_break_id
    
  LEFT OUTER JOIN RealAudit
  ON rcb_break_audit_id = audit_id
  
  
  -- ---------------------------------------------------------------
  -- CONDITIONS
  WHERE 1

  AND
    rcb_break_productivity = 1
  
    -- TIME AND DATE
    ${dateAndTimeSqlQueryRealTime(userSelection, "rcb_break_datetime_init")}
    
    -- AGENT
    ${arrayToSqlQuery(userSelection.agent, "inv_agent_id")}
    
    -- SUPERVISOR
  ${objectToJsonSqlQuery(
    userSelection.supervisor,
    "rcb_people_json",
    "supervisor"
  )}

  -- SCHEDULE
  ${objectToJsonSqlQuery(userSelection.client, "rcb_time_json", "schedule")}

  -- ROLE
  ${objectToJsonSqlQuery(userSelection.client, "rcb_people_json", "role")}

  -- CLIENT
  ${arrayToJsonSqlQuery(userSelection.client, "rcb_operation_json", "client")}

  -- QUEUE
  ${arrayToJsonSqlQuery(userSelection.queue, "rcb_operation_json", "queue")}

  -- SERVICE
  ${arrayToJsonSqlQuery(userSelection.service, "rcb_operation_json", "service")}

  -- CAMPAIGN
  ${arrayToJsonSqlQuery(
    userSelection.campaign,
    "rcb_operation_json",
    "campaign"
  )}
  
  -- BREAK
  ${arrayToSqlQuery(userSelection.auxiliar, "audit_break_id")}
  
  -- ASIGNACION
  ${arrayToSqlQuery(userSelection.assignation, "audit_break_id")}
  
  
  GROUP BY rcb_break_name
  
  -- END ---------------------------------------------------------

  `;

  try {
    let result = await pool.destiny.query(query);
    return result;
  } catch (error) {
    return (result = { error: error });
  }
}

/**************************************** */
// scale
async function scaleFunction(userSelection) {
  let result = null;
  let resume_error = false;
  let query = `
    SELECT
    *
    FROM
    InvScale
    WHERE
    inv_scale_name = '${process.env.COLORSCALE_NAME}'
  `;

  try {
    let result = await pool.destiny.query(query);
    return result;
  } catch (error) {
    return (result = { error: error });
  }
}

async function agentsHistoricBreakResumeFunction(userSelection) {
  let query = `
  SELECT
      inv_break_name as name
      ,inv_break_id as id
      ,count(DISTINCT audit_agent_id) as value
      ,SEC_TO_TIME( SUM( audit_duration_sec )) AS duration

      -- ---------------------------------------------------------------
      -- TABLES & JOINS
      
      FROM
      
      RealAudit
      LEFT OUTER JOIN InvAgent
      ON audit_agent_id = inv_agent_id
      
      LEFT OUTER JOIN InvBreak
      ON audit_break_id = inv_break_id
           
      -- ---------------------------------------------------------------
      -- CONDITIONS
    
    WHERE
    inv_break_productivity = 0
    AND
      inv_break_name is not null

      -- TIME AND DATE
      ${dateAndTimeSqlQueryRealTime(userSelection, "audit_datetime_init")}

      -- AGENT
      ${arrayToSqlQuery(userSelection.agent, "audit_agent_id")}

      -- SUPERVISOR
      ${objectToJsonSqlQuery(
    userSelection.supervisor,
    "audit_people_json",
    "supervisor"
  )}

      -- SCHEDULE
      ${objectToJsonSqlQuery(
    userSelection.client,
    "audit_time_json",
    "schedule"
  )}

      -- ROLE
      ${objectToJsonSqlQuery(userSelection.client, "audit_people_json", "role")}

      -- CLIENT
      ${arrayToJsonSqlQuery(
    userSelection.client,
    "audit_operation_json",
    "client"
  )}

      -- QUEUE
      ${arrayToJsonSqlQuery(
    userSelection.queue,
    "audit_operation_json",
    "queue"
  )}

      -- SERVICE
      ${arrayToJsonSqlQuery(
    userSelection.service,
    "audit_operation_json",
    "service"
  )}

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
    
      
      GROUP BY inv_break_name
`;

  try {
    let result = await pool.destiny.query(query);
    return result;
  } catch (error) {
    return (result = { error: error });
  }
}

async function agentsHistoricAssignationResumeFunction(userSelection) {
  let query = `
  SELECT
      inv_break_name as name
      ,inv_break_id as id
      ,count(DISTINCT audit_agent_id) as value
      ,SEC_TO_TIME( SUM( audit_duration_sec )) AS duration

      -- ---------------------------------------------------------------
      -- TABLES & JOINS
      
      FROM
      
      RealAudit
      LEFT OUTER JOIN InvAgent
      ON audit_agent_id = inv_agent_id
      
      LEFT OUTER JOIN InvBreak
      ON audit_break_id = inv_break_id
          
      -- ---------------------------------------------------------------
      -- CONDITIONS
    
    WHERE
    inv_break_productivity = 1
    AND
      inv_break_name is not null

      -- TIME AND DATE
    ${dateAndTimeSqlQueryRealTime(userSelection, "audit_datetime_init")}

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
    ${arrayToJsonSqlQuery(
    userSelection.client,
    "audit_operation_json",
    "client"
  )}

    -- QUEUE
    ${arrayToJsonSqlQuery(userSelection.queue, "audit_operation_json", "queue")}

    -- SERVICE
    ${arrayToJsonSqlQuery(
    userSelection.service,
    "audit_operation_json",
    "service"
  )}

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
    
      
      GROUP BY inv_break_name
`;

  try {
    let result = await pool.destiny.query(query);
    return result;
  } catch (error) {
    return (result = { error: error });
  }
}
