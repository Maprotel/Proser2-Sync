import * as pool from "../../../../connectors/pool";
import { removeRowDataPacket } from "../../../helpers/mysql-helper.js";

import {
  writeDestiny,
  readTableMaxIdByDate,
  minDate,
  readOriginByDateMaxNum,
  readOriginByDateMaxNumAllRecords
} from "./extract_cdr_functions";

import moment from "moment";

const destinyTable = "MainCdr";
const destinyTableReal = "RealCdr";
const destinyDateField = "cdr_calldate";
const destinyNumberField = "cdr_id";

const originTable = "asteriskcdrdb.cdr";
const originDateField = "calldate";
const originNumberField = "cdr.id";

let first_pass = true;
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function extractMainCdr(start_date) {
  console.log(`/*************/ Extracting ${destinyTable} /*************/ `);

  // Set date

  console.log("start_date", start_date);

  // SetMaximum Id Value
  let maxValueTemp = await readTableMaxIdByDate(
    start_date,
    destinyTable,
    destinyDateField,
    destinyNumberField
  ).catch(err =>
    console.log(`${destinyTable} caught it - readTableMaxIdByDate`, err)
  );

  let maxValue = maxValueTemp ? removeRowDataPacket(maxValueTemp)[0].maxId : "";

  let preresult;

  start_date === moment().format("YYYY-MM-DD")
    ? (preresult = await readOriginByDateMaxNum(
      start_date,
      originTable,
      originDateField,
      originNumberField,
      maxValue
    ).catch(err =>
      console.log(`${destinyTable} caught it - readOriginByDateMaxNum`, err)
    ))
    : (preresult = await readOriginByDateMaxNumAllRecords(
      start_date,
      originTable,
      originDateField,
      originNumberField,
      maxValue
    ).catch(err =>
      console.log(`${destinyTable} caught it - readOriginByDateMaxNum`, err)
    ));

  let result = removeRowDataPacket(preresult);

  try {
    let extendedResult;
    let written;
    let msg = "";
    let validation = "";

    if (Array.isArray(result) && result.length > 0) {
      extendedResult = result
        .map(x => {
          return x;
        })
        .map(y => {
          return y;
        });
    }

    written;
    msg = "extractMainCdr end";

    validation =
      Array.isArray(extendedResult) && extendedResult.length > 0 ? true : false;

    validation === true
      ? (written = await writeDestiny(extendedResult, destinyTable).catch(err =>
        console.log("extractMainCdr caught it - writeDestiny", err)
      ))
      : (msg = `No hay registros nuevos por actualizar en ${destinyTable}`);

    return msg;
  } catch (e) {
    console.log("e", e);
    return e;
  }
}

/************************************************************************ */

module.exports = {
  extractMainCdr
};
