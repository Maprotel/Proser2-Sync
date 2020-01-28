import * as pool from "../../../../connectors/pool";
import { removeRowDataPacket } from "../../../helpers/mysql-helper.js";
import { writeDestiny, readOriginAllRecords } from "./extract-functions-inv";
import moment from "moment";

// CONSTANTS
const originTable = "call_center.agent";
const destinyTable = "InvAgent";
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function extractInvAgent(start_date) {

  start_date = start_date ? start_date : moment().format('YYYY-MM-DD');

  // Console notification
  console.log(`/*************/ Extracting ${destinyTable} /*************/ `);
  console.log("start_date", start_date);

  // Read origin data
  let records = await readOriginAllRecords(originTable).catch(err =>
    console.log(`${destinyTable} caught it - readOriginAllRecords`, err)
  );

  console.log("records", records.length);

  // Transform data to import
  if (Array.isArray(records) && records.length > 0) {
    let extendedResult = records
      .map(x => {
        x.inv_agent_id = x.id;
        x.inv_agent_type = x.type;
        x.inv_agent_extension = x.number;
        x.inv_agent_name = x.name;
        x.inv_agent_status = x.estatus;

        return x;
      })
      .map(y => {
        delete y.id;
        delete y.type;
        delete y.number;
        delete y.name;
        delete y.password;
        delete y.estatus;
        delete y.eccp_password;

        return y;
      });

    // Write process data to destiny
    let validation =
      Array.isArray(extendedResult) && extendedResult.length > 0 ? true : false;

    if (validation) {
      try {
        let written = await writeDestiny(extendedResult, destinyTable).catch(
          err => console.log("extractInvAgent caught it - writeDestiny", err)
        );

        return { function: "extractInvAgent ", result: written };
      } catch (error) {
        console.log("error", error);
        return { error: error };
      }
    }
  }
}

/************************************************************************ */

// npx babel-node src/sync/etl/extract/inv/extract-all-inv.js
// extractInvAgent();

module.exports = {
  extractInvAgent
};
