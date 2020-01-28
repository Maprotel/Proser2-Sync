import * as pool from "../../../../../connectors/pool";
import { removeRowDataPacket } from "../../../../../helpers/mysql-helper";
import { writeDestiny, readOriginAllRecords } from "../transform-functions-inv";
import moment from "moment";
// import custom functions
import * as queueFunctions from "./transform_queue_functions";
import { readOriginQueue } from "./transform_queue_functions";

const destinyTable = "InvQueue";
const originTable = "InvQueue";
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function transformInvQueue(start_date) {
  start_date = start_date ? start_date : moment().format("YYYY-MM-DD");

  console.log(`/*************/ Transform ${destinyTable} /*************/ `);
  console.log("start_date", start_date);
  // Read origin data
  let records = await queueFunctions
    .readOriginQueue(originTable)
    .catch(err =>
      console.log(`${destinyTable} caught it - readOriginQueue`, err)
    );

  console.log("records", records.length);

  // Transform data to import
  if (Array.isArray(records) && records.length > 0) {
    let extendedResult = records
      .map(x => {
        x.inv_queue_operation_json = queueFunctions.inv_queue_operation_json(
          x.inv_queue_operation_json,
          x.inv_queue_id,
          x.inv_queue_name,
          x.inv_queue_number
        );
        x.inv_queue_chk = 3;
        x.inv_queue_shortname = queueFunctions.inv_queue_shortname(
          x.inv_queue_shortname,
          x.inv_queue_name
        );

        x.inv_queue_name = `${x.inv_queue_number} - ${x.inv_queue_name}`;

        return x;
      })
      .map(y => {
        return y;
      });

    // Write process data to destiny
    let validation =
      Array.isArray(extendedResult) && extendedResult.length > 0 ? true : false;

    if (validation) {
      try {
        let written = await writeDestiny(extendedResult, destinyTable).catch(
          err => console.log("transformInvQueue caught it - writeDestiny", err)
        );

        return { function: "transformInvQueue ", result: written };
      } catch (error) {
        console.log("error", error);
        return { error: error };
      }
    }
  }
}

/************************************************************************ */

// npx babel-node src/sync/etl/transform/inv/queue/transform_queue.js
// transformInvQueue(incoming_date);

module.exports = {
  transformInvQueue
};
