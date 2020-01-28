import * as pool from "../../../../connectors/pool";
import { removeRowDataPacket } from "../../../helpers/mysql-helper.js";
import { writeDestiny, readOriginAllRecords } from "./extract-functions-inv";
import moment from "moment";

// CONSTANTS

const originTable = "call_center.campaign";
const destinyTable = "InvCampaign";
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function extractInvCampaign(start_date) {
  start_date = start_date ? start_date : moment().format('YYYY-MM-DD')
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

        x.inv_campaign_id = x.id;

        x.inv_campaign_status = x.estatus;

        x.inv_campaign_name = x.name;
        x.inv_campaign_shortname = x.name;

        x.inv_campaign_start_date = x.datetime_init;
        x.inv_campaign_end_date = x.datetime_end;
        x.inv_campaign_start_time = x.daytime_init;
        x.inv_campaign_end_time = x.daytime_end;

        // calc

        x.inv_campaign_queue_number = x.queue;
        x.inv_campaign_queue_id = 1; //campaignFunctions.inv_campaign_queue_id(thisQueueClean, x.queue);
        x.inv_campaign_queue_name = 1; //campaignFunctions.inv_campaign_queue_name(thisQueueClean, x.queue);
        x.inv_campaign_description = 1; //campaignFunctions.inv_campaign_description(thisQueueClean, x.queue);
        x.inv_campaign_aftercall_time = null;

        return x;
      })
      .map(y => {
        delete y.id;

        delete y.name;
        delete y.datetime_init;
        delete y.datetime_end;
        delete y.daytime_init;
        delete y.daytime_end;
        delete y.retries;
        delete y.trunk;
        delete y.context;
        delete y.queue;
        delete y.max_canales;
        delete y.num_completadas;
        delete y.promedio;
        delete y.desviacion;
        delete y.script;
        delete y.estatus;
        delete y.id_url;

        return y;
      });

    let validation =
      Array.isArray(extendedResult) && extendedResult.length > 0 ? true : false;

      if (validation) {
        try {
          let written = await writeDestiny(extendedResult, destinyTable).catch(
            err => console.log("extractInvCampaign caught it - writeDestiny", err)
          );
  
          return { function: "extractInvCampaign ", result: written };
        } catch (error) {
          console.log("error", error);
          return { error: error };
        }
      }
    }
  }
  
/************************************************************************ */

// npx babel-node src/sync/etl/extract/inv/extract_agent.js
// extractInvCampaign();

module.exports = {
  extractInvCampaign
};
