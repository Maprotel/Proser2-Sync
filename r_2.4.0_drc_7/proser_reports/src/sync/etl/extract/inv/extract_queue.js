import * as pool from "../../../../connectors/pool";
import { removeRowDataPacket } from "../../../helpers/mysql-helper.js";
import { writeDestiny, readOriginAllRecords } from "./extract-functions-inv";
import moment from "moment";

// CONSTANTS
const originTable = "call_center.queue_call_entry";
const destinyTable = "InvQueue";
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function extractInvQueue(start_date) {
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
        // date

        x.inv_queue_number = x.queue;

        x.inv_queue_name = x.descr;

        x.inv_queue_id = x.id;
        x.inv_queue_status = x.estatus;

        return x;
      })
      .map(y => {
        delete y.queue;
        delete y.estatus;
        delete y.id;
        delete y.extension;
        delete y.descr;
        delete y.date_init;
        delete y.time_init;
        delete y.date_end;
        delete y.time_end;
        delete y.script;

        return y;
      });

    let validation =
      Array.isArray(extendedResult) && extendedResult.length > 0 ? true : false;

    if (validation) {
      try {
        let written = await writeDestiny(extendedResult, destinyTable).catch(
          err => console.log("extractInvQueue caught it - writeDestiny", err)
        );

        return { function: "extractInvQueue ", result: written };
      } catch (error) {
        console.log("error", error);
        return { error: error };
      }
    }
  }
}

/************************************************************************ */

// npx babel-node src/sync/etl/extract/inv/extract_agent.js
// extractInvQueue();

module.exports = {
  extractInvQueue
};
