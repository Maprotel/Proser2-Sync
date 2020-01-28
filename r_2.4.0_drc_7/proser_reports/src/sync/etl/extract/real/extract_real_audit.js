import * as pool from "../../../../connectors/pool";
import { removeRowDataPacket } from "../../../../helpers/mysql-helper";
import { writeDestiny, readOriginByDate } from "./extract-functions-real";
import moment from "moment";

// Constants
const destinyTable = "RealAudit";
const originTable = "MainAudit";
const datefield = "audit_datetime_init";
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function extractRealAudit(start_date) {
  start_date = start_date ? start_date : moment().format("YYYY-MM-DD");

  // Console notification
  console.log(`/*************/ Transform ${destinyTable} /*************/ `);
  console.log("start_date", start_date);

  // Read origin data
  let preresult = await readOriginByDate(
    start_date,
    originTable,
    datefield
  ).catch(err =>
    console.log(`${destinyTable} caught it - readOriginAllRecords`, err)
  );

  let records = removeRowDataPacket(preresult);

  console.log("records", records.length);

  // Transform data to import
  if (Array.isArray(records) && records.length > 0) {
    let extendedResult = records
      .map(x => {
        x.audit_datetime_init =
          x.audit_datetime_init === null
            ? null
            : moment(x.audit_datetime_init).format("YYYY-MM-DD hh:mm:ss");

        x.audit_datetime_end =
          x.audit_datetime_end === null
            ? null
            : moment(x.audit_datetime_end).format("YYYY-MM-DD hh:mm:ss");

        x.audit_date = moment(x.audit_datetime_init).format("YYYY-MM-DD");

        x.audit_hca_agent_serial_id =
          x.audit_datetime_init === null
            ? null
            : moment(x.audit_datetime_init).format("YYYY-MM-DD") +
              "-" +
              x.audit_agent_id;

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
          err => console.log("extractRealAudit caught it - writeDestiny", err)
        );

        return { function: "extractRealAudit ", result: written };
      } catch (error) {
        console.log("error", error);
        return { error: error };
      }
    }
  }
}

/************************************************************************ */

// npx babel-node src/sync/etl/extract/real/extract_real_main_audit.js
// extractRealAudit(incoming_date);

module.exports = {
  extractRealAudit
};
