import * as pool from "../../../../../connectors/pool";
import {
  removeRowDataPacket,
  removeRowDataPacketArray
} from "../../../../helpers/mysql-helper";
import {
  writeDestiny,
  readOriginByDate,
  readOriginByStatus,
  previousDate,
  minDate,
  startDate
} from "../transform-functions-main";

import * as auditFunctions from "./transform_audit_functions";

import moment from "moment";

const destinyTable = "MainAudit";
const destinyTableReal = "RealAudit";
const destinyDateField = "audit_datetime_init";
const destinyStatusField = "audit_status";

const originTable = "MainAudit";
const originDateField = "datetime_init";
const originStatusField = "";

let first_pass = true;
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function transformMainAudit(start_date) {
  start_date = start_date ? start_date : moment().format("YYYY-MM-DD");

  // Console notification
  console.log(`/*************/ Transform ${destinyTable} /*************/ `);
  console.log("start_date", start_date);

  if (start_date) {
    let preResult = await auditFunctions
      .readOriginAudit(start_date, destinyTable, destinyDateField)
      .catch(err =>
        console.log(`${destinyTable} caught it - readOriginAudit`, err)
      );

    let records = removeRowDataPacket(preResult);

    console.log("records", records.length);

    if (Array.isArray(records) && records.length > 0) {
      let extendedResult = records
        .map(x => {
          // x.audit_duration = "00:00:00";
          x.audit_duration_sec = moment.duration(x.audit_duration).asSeconds();
          x.audit_status = x.audit_duration ? `I` : `A`;

          // x.audit_date = moment(x.audit_datetime_init).format("YYYY-MM-DD");

          x.audit_datetime_end = x.audit_datetime_end
            ? moment(x.audit_datetime_end).format("YYYY-MM-DD HH:mm:ss")
            : null;

          x.audit_datetime_init = x.audit_datetime_init
            ? moment(x.audit_datetime_init).format("YYYY-MM-DD HH:mm:ss")
            : null;

          x.audit_operation_json = x.Accounts;
          x.__TIME__ = 1;

          x.audit_hca_agent_serial_id = `${moment(x.audit_date).format(
            "YYYY-MM-DD"
          )}-${x.audit_agent_id}`;

          x.audit_people_json = x.inv_agent_people_json;
          x.audit_operation_json = x.inv_agent_operation_json;
          x.audit_time_json = x.inv_agent_time_json;

          return x;
        })
        .map(y => {
          delete y.audit_date;
          delete y.audit_agent_id;
          delete y.inv_agent_people_json;
          delete y.inv_agent_operation_json;
          delete y.inv_agent_time_json;

          delete y.Accounts;
          delete y.audit_date;
          delete y.inv_agent_operation_json;

          return y;
        });

      let validation = extendedResult[0] ? true : false;

      if (validation) {
        try {
          let written;
          written = await writeDestiny(extendedResult, destinyTable).catch(
            err =>
              console.log("transformMainAudit caught it - writeDestiny", err)
          );

          return "transformMainAudit end";
        } catch (e) {
          console.log("e", e);
          return e;
        }
      } else {
        console.log(`********************************************`);
        console.log(`El resultado está vacío en ${originTable}`);
      }
    } else {
      console.log(`********************************************`);
      console.log(`No hay registros nuevos por actualizar en ${destinyTable}`);
    }

    return "transformMainAudit end";
  }
}

/************************************************************************ */

// npx babel-node src/sync/etl/transform/main/audit/transform_audit.js
// transformMainAudit(incoming_date);

module.exports = {
  transformMainAudit
};
