import * as pool from "../../../../connectors/pool";
import { removeRowDataPacket } from "../../../helpers/mysql-helper.js";
import { writeDestiny, readOriginAllRecords } from "./extract-functions-inv";
import moment from "moment";

// CONSTANTS
const originTable = "call_center.break";
const destinyTable = "InvBreak";
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function extractInvBreak(start_date) {
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
        x.inv_break_id = x.id;
        x.inv_break_name = x.name;
        x.inv_break_description = x.description;
        x.inv_break_status = x.status;
        x.inv_break_type = x.tipo;

        return x;
      })
      .map(y => {
        delete y.id;
        delete y.name;
        delete y.description;
        delete y.status;
        delete y.tipo;

        return y;
      });

    let validation =
      Array.isArray(extendedResult) && extendedResult.length > 0 ? true : false;

    if (validation) {
      try {
        let written = await writeDestiny(extendedResult, destinyTable).catch(
          err => console.log("extractInvBreak caught it - writeDestiny", err)
        );

        return { function: "extractInvBreak ", result: written };
      } catch (error) {
        console.log("error", error);
        return { error: error };
      }
    }
  }
}

/************************************************************************ */

// npx babel-node src/sync/etl/extract/inv/extract_agent.js
// extractInvBreak();

module.exports = {
  extractInvBreak
};
