import * as pool from "../../../../../connectors/pool";
import { removeRowDataPacket } from "../../../../helpers/mysql-helper";
import {
  writeDestiny,
  readOriginByDate,
  readOriginByStatus,
  previousDate,
  minDate,
  startDate
} from "../transform-functions-main";

import { readOriginCdr } from "./transform_cdr_functions";

import * as datesFunctions from "./cdr_dates_functions";
import * as typeFunctions from "./cdr_type_functions";
import * as callFunctions from "./cdr_call_functions";
import * as minMaxFunctions from "./min_max.js";
import * as queryCdrFunctions from "./cdr_query_functions";

import moment from "moment";

const destinyTable = "MainCdr";
const destinyTableReal = "RealCdr";
const destinyDateField = "";
const destinyStatusField = "calldate";

const originTable = "MainCdr";
const originDateField = "";
const originStatusField = "calldate";

let first_pass = true;
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function transformMainCdr(start_date) {
  start_date = start_date ? start_date : moment().format("YYYY-MM-DD");

  // Console notification
  console.log(`/*************/ Transform ${destinyTable} /*************/ `);
  console.log("start_date", start_date);

  let numberPattern = /\d+/g;

  if (start_date) {
    let result = await readOriginCdr(
      start_date,
      originTable,
      originStatusField
    ).catch(err =>
      console.log(`${destinyTable} caught it - readOriginCdr`, err)
    );

    if (Array.isArray(result) && result.length > 0) {
      let extendedResult = result
        .map(x => {
          x.cdr_callcenter_name = process.env.CDR_CALLCENTER_NAME;

          x.cdr_queue_id = x.callentry_queue_id;

          // // x.__CLASSIFICATION__
          x.cdr_call_type = callFunctions.cdr_call_type(
            x.cdr_src,
            x.cdr_dst,
            x.cdrcontext,
            x.callentry_id,
            x.callentry_type
          );

          x.cdr_agent_extension =
            x.cdr_call_type === "inbound" ? x.cdr_dst : x.cdr_agent_extension;

          x.cdr_agent_extension =
            x.cdr_call_type === "outbound" ? x.cdr_src : x.cdr_agent_extension;

          x.cdr_queue_number = x.callentry_queue_number;

          x.cdr_call_class = callFunctions.cdr_call_class(
            x.cdr_src,
            x.cdr_dst,
            x.cdr_lastapp,
            x.cdr_type_queue
          );

          x.__MADE__;
          x.cdr_call_made = callFunctions.cdr_call_made(x.cdr_call_type);
          x.cdr_call_fail = callFunctions.cdr_call_fail(
            x.cdr_call_made,
            x.cdr_disposition,
            x.cdr_lastapp
          );
          x.cdr_call_answered = callFunctions.cdr_call_answered(
            x.cdr_call_made,
            x.cdr_disposition
          );
          x.cdr_call_hungout = callFunctions.cdr_call_hungout(
            x.cdr_call_made,
            x.cdr_lastapp
          );

          x.cdr_hca_agent_serial_id = `${moment(x.cdr_date).format(
            "YYYY-MM-DD"
          )}-${x.cdr_agent_id}`;
          x.cdr_hca_queue_serial_id = `${moment(x.cdr_date).format(
            "YYYY-MM-DD"
          )}-${x.cdr_agent_id}`;

          x.cdr_people_json = x.inv_agent_people_json;
          x.cdr_operation_json = x.inv_queue_operation_json;
          x.cdr_time_json = x.inv_agent_time_json;

          return x;
        })
        .map(y => {
          delete y.inv_agent_id;
          delete y.inv_agent_id;
          delete y.inv_queue_id;
          delete y.inv_agent_people_json;
          delete y.inv_agent_operation_json;
          delete y.inv_agent_time_json;

          delete y.inv_queue_number;

          delete y.cdr_date;

          delete y.cdr_type_ext_in_long;
          delete y.cdr_type_ext_in;
          delete y.cdr_type_extension;
          delete y.cdr_type_ext_out;

          delete y.cdr_type_int_ext;
          delete y.cdr_type_out_ent;
          delete y.cdr_type_in_out_empty;
          delete y.cdr_type_in_out;
          delete y.cdr_type_prod;

          delete y.cdr_call_class;

          delete y.hca_agent_id;
          delete y.hca_queue_id;

          delete y.inv_agent_id;

          delete y.callentry_agent_extension;
          delete y.callentry_queue_number;

          delete y.callentry_id;
          delete y.callentry_agent_id;
          delete y.callentry_queue_id;
          delete y.callentry_type;

          delete y.cdr_type_prod_call;

          delete y.cdr_type_queue;
          delete y.hca_agent_serial_id;
          delete y.hca_queue_serial_id;

          delete y.hca_agent_people_json;
          delete y.hca_agent_time_json;
          delete y.hca_queue_operation_json;

          delete y.inv_queue_operation_json;
          delete y.inv_queue_system_json;

          return y;
        });

      let validation = extendedResult[0] ? true : false;

      if (validation) {
        try {
          let written;

          written = await writeDestiny(extendedResult, destinyTable).catch(
            err => console.log("transformMainCdr caught it - writeDestiny", err)
          );

          return "transformMainCdr end";
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

    return "transformMainCdr end";
  }
}

/************************************************************************ */

// npx babel-node src/sync/etl/transform/main/cdr/transform_cdr.js
// transformMainCdr(incoming_date);

module.exports = {
  transformMainCdr
};
