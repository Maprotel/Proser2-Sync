import * as pool from "../../../../../connectors/pool";
import { removeRowDataPacket } from "../../../../../helpers/mysql-helper";
import { writeDestiny, readOriginAllRecords } from "../transform-functions-inv";
import moment from "moment";
// import custom functions
import * as campaignFunctions from "./transform_campaign_functions";

const destinyTable = "InvCampaign";
const originTable = "InvCampaign";
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function transformInvCampaign(start_date) {
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
          err =>
            console.log("transformInvCampaign caught it - writeDestiny", err)
        );

        return { function: "transformInvCampaign ", result: written };
      } catch (error) {
        console.log("error", error);
        return { error: error };
      }
    }
  }
}

/************************************************************************ */

// npx babel-node src/sync/etl/transform/inv/campaign/transform_campaign.js
// transformInvCampaign();

module.exports = {
  transformInvCampaign
};
