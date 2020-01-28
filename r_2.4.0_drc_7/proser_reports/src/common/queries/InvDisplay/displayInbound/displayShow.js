// DISPLAY INBOUND REPORT
/**********************************
 * Tip vscode:
 * ctrl+k & ctrl+0 to view collapsed - ctrl+k & ctrl+j to expand
 */

// IMPORTS
import * as pool from "../../../../connectors/pool";
import moment from "moment";

export async function displayShow(type) {
  let result;
  let resume_error = false;

  if(userSelection.mode.name='Actual'){
    userSelection.start_date = userSelection.current_date;
    userSelection.end_date = userSelection.end_date;
  }

  let currentDate = moment().format("HH:mm:ss");

  if (type === null) {
    type = "inbound";
  }

  let query = `
  SET STATEMENT max_statement_time=5 FORnpm run history
  
  SELECT * FROM ProShowDisplay WHERE 
  
  pro_show_display_start_time <= '${currentDate}'
  AND
  pro_show_display_end_time >=  '${currentDate}'
  AND
  JSON_UNQUOTE(JSON_EXTRACT(pro_show_display_type, "$.value")) = 'inbound'

  order by pro_show_display_start_time desc
  
  limit 1
          `;

  console.log("query", query);

  try {
    result = await pool.destinyReports.query(query);
    return result;
  } catch (error) {
    resume_error = true;
    return {
      error: "displayShow " + error
    };
  }
}
