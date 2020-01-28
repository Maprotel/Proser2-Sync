import * as pool from "../../../../connectors/pool";
import { removeRowDataPacket } from "../../../helpers/mysql-helper.js";
import { writeDestiny, readOriginAllRecords } from "./extract-functions-inv";
import moment from "moment";

// CONSTANTS
const originTable = "asterisk.queues_config";
const destinyTable = "InvQueueConfig";
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function extractInvQueueConfig(start_date) {
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
        x.queueconfig_extension = x.extension;
        x.queueconfig_descr = x.descr;
        x.queueconfig_grppre = x.grppre;
        x.queueconfig_alertinfo = x.alertinfo;
        x.queueconfig_ringing = x.ringing;
        x.queueconfig_maxwait = x.maxwait;
        x.queueconfig_password = x.password;
        x.queueconfig_ivr_id = x.ivr_id;
        x.queueconfig_dest = x.dest;
        x.queueconfig_cwignore = x.cwignore;
        x.queueconfig_qregex = x.qregex;
        x.queueconfig_agentannounce_id = x.agentannounce_id;
        x.queueconfig_joinannounce_id = x.joinannounce_id;
        x.queueconfig_queuewait = x.queuewait;
        x.queueconfig_use_queue_context = x.use_queue_context;
        x.queueconfig_togglehint = x.togglehint;
        x.queueconfig_qnoanswer = x.qnoanswer;
        x.queueconfig_callconfirm = x.callconfirm;
        x.queueconfig_callconfirm_id = x.callconfirm_id;
        x.queueconfig_monitor_type = x.monitor_type;
        x.queueconfig_monitor_heard = x.monitor_heard;
        x.queueconfig_monitor_spoken = x.monitor_spoken;
        x.queueconfig_callback_id = x.callback_id;

        return x;
      })
      .map(y => {
        delete y.extension;
        delete y.descr;
        delete y.grppre;
        delete y.alertinfo;
        delete y.ringing;
        delete y.maxwait;
        delete y.password;
        delete y.ivr_id;
        delete y.dest;
        delete y.cwignore;
        delete y.qregex;
        delete y.agentannounce_id;
        delete y.joinannounce_id;
        delete y.queuewait;
        delete y.use_queue_context;
        delete y.togglehint;
        delete y.qnoanswer;
        delete y.callconfirm;
        delete y.callconfirm_id;
        delete y.monitor_type;
        delete y.monitor_heard;
        delete y.monitor_spoken;
        delete y.callback_id;
        delete y.destcontinue;

        return y;
      });

    let validation =
      Array.isArray(extendedResult) && extendedResult.length > 0 ? true : false;

    if (validation) {
      try {
        let written = await writeDestiny(extendedResult, destinyTable).catch(
          err =>
            console.log("extractInvQueueConfig caught it - writeDestiny", err)
        );

        return { function: "extractInvQueueConfig ", result: written };
      } catch (error) {
        console.log("error", error);
        return { error: error };
      }
    }
  }
}

/************************************************************************ */

// npx babel-node src/sync/etl/extract/inv/extract_agent.js
// extractInvQueueConfig();

module.exports = {
  extractInvQueueConfig
};
