import * as pool from "../../../connectors/pool";
import moment from "moment";

export async function userSelectionChange () {
  let result;
  let resume_error = false;

  let query = `
    SELECT 
    
    JSON_UNQUOTE(JSON_EXTRACT(pro_show_display_selection, '$.start_time.value')) as start_time
    
    , pro_show_display_selection as userSelection FROM ProShowDisplay ORDER BY start_time DESC
          `;


  try {
    result = await pool.destinyInventory.query( query );
    return result;
  } catch ( error ) {
    resume_error = true;
    return {
      error: "callEntry - userSelectionChange " + error
    };
  }
}
