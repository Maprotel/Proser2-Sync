// DASHBOARD INBOUND CURRENT CALLS
/**********************************
 * Tip vscode:
 * ctrl+k & ctrl+0 to view collapsed - ctrl+k & ctrl+j to expand
 */

// IMPORTS
import * as pool from "../../../../../connectors/pool";
import {
  objectDateToTextDate,
  valueFromObject
} from "../../../../functions/dateFunctions";

import {
  dateAndTimeSqlQuery,
  dateAndTimeSqlQueryRealTime,
  arrayToSqlQuery,
  arrayToJsonSqlQuery,
  objectToJsonSqlQuery,
  sqlIntervalSqlQuery,
  sqlIntervalGroupSqlQuery
} from "../../../../functions/sqlFunctions";

/**************************************** */
// Call Entry List
export async function dashboardInboundListCurrentBreaksRealTime(DashboardSelection) {
  let result = null;
  let resume_error = false;
  let userSelection = DashboardSelection.userSelection;
  let modalView = DashboardSelection.modalView;
  let type = DashboardSelection.type;

  if(userSelection.mode.name='Actual'){
    userSelection.start_date = userSelection.current_date;
    userSelection.end_date = userSelection.end_date;
  }

  let query = `

  -- dashboardInboundListCurrentBreaksFunction --------------------
  -- FIELDS
  SET STATEMENT max_statement_time=50 FOR
  SELECT
  
  now() as now
      
  ,rcb_break_agent_id as agent_id
  ,inv_agent_name as agent_name
  ,rcb_break_name as group_name
  ,rcb_break_duration as duration
  ,JSON_UNQUOTE(JSON_EXTRACT(rcb_people_json, "$.supervisor[0].name") ) as supervisor_name
  ,JSON_UNQUOTE(JSON_EXTRACT(rcb_time_json, "$.schedule[0].name") ) as schedule_name
  
  -- ---------------------------------------------------------------
  -- TABLES & JOINS
  
  FROM
  
  RealCurrentBreaks
  LEFT OUTER JOIN InvAgent
  ON rcb_break_agent_id = inv_agent_id
   
   
   -- -----------------------------
   WHERE 1
   
   AND
   ${sqlModalView(modalView)}
   
   -- TIME AND DATE
   ${dateAndTimeSqlQueryRealTime(userSelection, "rcb_break_datetime_init")}
   
   -- AGENT
   ${arrayToSqlQuery(userSelection.agent, "rcb_break_agent_id")}
   
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
   ${arrayToJsonSqlQuery(
    userSelection.service,
    "rcb_operation_json",
    "service"
  )}
 
   -- CAMPAIGN
   ${arrayToJsonSqlQuery(
    userSelection.campaign,
    "rcb_operation_json",
    "campaign"
  )}
   
   -- BREAK
   ${arrayToSqlQuery(userSelection.auxiliar, "rcb_break_id")}
   
   -- ASIGNACION
   ${arrayToSqlQuery(userSelection.assignation, "rcb_break_id")}
   
   GROUP BY inv_agent_name
     
   -- END ---------------------------------------------------------------

  `;

  // console.log(query);
  try {
    result = await pool.destiny.query(query);
    return result;
  } catch (error) {
    return (result = { errorDetail: error });
  }
}

export function sqlModalView(modalView) {
  /*
   * Inserts interval fields in the select statment when interval applies
   */
  let result = null;

  if (modalView === "asignado" || modalView === "asignacion") {
    return `
    rcb_break_productivity = 1
    `;
  } else if (modalView === "auxiliar") {
    return `
    rcb_break_productivity = 0
    `;
  }
  return result;
}
