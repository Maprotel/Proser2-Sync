import * as pool from "../../../../../connectors/pool";
import { removeRowDataPacket } from "../../../../../helpers/mysql-helper";
import { writeDestiny, readOriginAllRecords } from "../transform-functions-inv";
import moment from "moment";
// import custom functions
import * as breakFunctions from "./transform_break_functions";

const destinyTable = "InvBreak";
const originTable = "InvBreak";
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function transformInvBreak(start_date) {
  start_date = start_date ? start_date : moment().format("YYYY-MM-DD");

  // Console notification
  console.log(`/*************/ Transform ${destinyTable} /*************/ `);
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
        x.inv_break_chk = 1;
        x.inv_break_shortname = breakFunctions.inv_break_shortname(
          x.inv_break_name,
          x.inv_break_shortname
        );

        x.inv_break_codename = breakFunctions.inv_break_codename(
          x.inv_break_name
        );

        // x.inv_break_productivity = 0;

        x.inv_break_class =
          x.inv_break_productivity === 0 ? "Auxiliar" : "Asignación";

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
          err => console.log("transformInvBreak caught it - writeDestiny", err)
        );

        return { function: "transformInvBreak ", result: written };
      } catch (error) {
        console.log("error", error);
        return { error: error };
      }
    }
  }
}

/************************************************************************ */

// npx babel-node src/sync/etl/transform/inv/break/transform_break.js
// transformInvBreak();

module.exports = {
  transformInvBreak
};
