import * as pool from "../../../../../connectors/pool";
import { removeRowDataPacket } from "../../../../helpers/mysql-helper";
import {
  writeDestiny,
  readOriginByDate,
  readOriginByStatus,
  previousDate,
  minDate,
  startDate
} from "../../transform_functions_inv";

import * as campaignFunctions from "./transform_campaign_functions";
import moment from "moment";

const destinyTable = "InvCampaign";
const destinyDateField = "";
const destinyStatusField = "";

const originTable = "InvCampaign";
const originDateField = "";
const originStatusField = "";

let first_pass = true;
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function transformInvCampaign(start_date) {
  console.log(`/*************/ Transform ${destinyTable} /*************/ `);

  // start_date = process.argv[2];
  
  // if (!start_date) {
  //   start_date = moment(new Date()).format("YYYY-MM-DD");
  // } else {
  //   start_date = process.argv[2];
  // }

  console.log("start_date", start_date);

  let val = true;

  if (val) {
    let result = await campaignFunctions
      .readOriginCampaign(start_date, originTable, originStatusField)
      .catch(err =>
        console.log(`${destinyTable} caught it - readOriginCampaign`, err)
      );

    if (Array.isArray(result) && result.length > 0) {
      let extendedResult = result
        .map(x => {
          return x;
        })
        .map(y => {
          return y;
        });

      let validation = extendedResult[0] ? true : false;

      if (validation) {
        try {
          let written = await writeDestiny(extendedResult, destinyTable).catch(
            err =>
              console.log("transformInvCampaign caught it - writeDestiny", err)
          );
          return "transformInvCampaign end";
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
  }
  return "transformInvCampaign end";
}

/***************************************************************************** */

module.exports = {
  transformInvCampaign
};
