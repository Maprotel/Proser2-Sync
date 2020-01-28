import * as pool from "../../../../../connectors/pool";
import { removeRowDataPacket } from "../../../../helpers/mysql-helper";
import {
  writeDestiny,
  readOriginByDate,
  readOriginByStatus,
  previousDate,
  minDate,
  startDate
} from "../../transform_functions";

import * as callentryFunctions from "./transform_callentry_functions";

import moment from "moment";

const destinyTable = "MainCallEntry";
const destinyTableReal = "RealCallEntry";
const destinyDateField = "";
const destinyStatusField = "callentry_datetime_entry_queue";

const originTable = "MainCallEntry";
const originDateField = "";
const originStatusField = "callentry_datetime_entry_queue";

let first_pass = true;
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function transformMainCallEntry(start_date) {
  console.log(`/*************/ Transform ${destinyTable} /*************/ `);

  if (start_date) {
    console.log("start_date", start_date);

    let result = await callentryFunctions
      .readOriginCall(start_date, originTable, originStatusField)
      .catch(err =>
        console.log(`${destinyTable} caught it - readOriginCdr`, err)
      );

    if (Array.isArray(result) && result.length > 0) {
      let extendedResult = result
        .map(x => {
          x.callentry_who_hung = x.queuelog_event;
          x.callentry_hung_agent =
            x.callentry_who_hung === "COMPLETEAGENT" ? 1 : null;
          x.callentry_hung_caller =
            x.callentry_who_hung === "COMPLETECALLER" ? 1 : null;

          x.callentry_hca_agent_serial_id = `${moment(x.callentry_date).format(
            "YYYY-MM-DD"
          )}-${x.callentry_agent_id}`;

          x.callentry_people_json = x.inv_agent_people_json;
          x.callentry_operation_json = x.inv_queue_operation_json;
          x.callentry_time_json = x.inv_agent_time_json;

          return x;
        })
        .map(y => {
          delete y.callentry_date;
          delete y.callentry_agent_id;
          delete y.inv_agent_people_json;
          delete y.inv_agent_operation_json;
          delete y.inv_agent_time_json;

          delete y.queuelog_event;
          delete y.callentry_date;

          delete y.inv_queue_operation_json;
          delete y.inv_queue_system_json;

          return y;
        });

      let validation = extendedResult[0] ? true : false;

      if (validation) {
        try {
          let written;

          written = await writeDestiny(extendedResult, destinyTable).catch(
            err =>
              console.log(
                "transformMainCallEntry caught it - writeDestiny",
                err
              )
          );
          return "transformMainCallEntry end";


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

    return "transformMainCallEntry end";
  }
}
/************************************************************************ */

module.exports = {
  transformMainCallEntry
};
