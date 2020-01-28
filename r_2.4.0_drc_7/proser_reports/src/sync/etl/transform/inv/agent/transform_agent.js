import * as pool from "../../../../../connectors/pool";
import { removeRowDataPacket } from "../../../../../helpers/mysql-helper";
import { writeDestiny, readOriginAllRecords } from "../transform-functions-inv";
import moment from "moment";
// import custom functions
import * as agentFunctions from "./transform_agent_functions";

const destinyTable = "InvAgent";
const originTable = "InvAgent";
let incoming_date = process.argv[2];

/******************* Running actual program -- exec*/
async function transformInvAgent(start_date) {
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
        x.inv_agent_shortname = agentFunctions.inv_agent_shortname(
          x.inv_agent_shortname,
          x.inv_agent_name
        );

        x.inv_agent_chk = 1;

        x.inv_agent_people_json = agentFunctions.inv_agent_people_json(
          x.inv_agent_people_json,
          x.inv_agent_id,
          x.inv_agent_name,
          x.inv_agent_extension
        );

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
          err => console.log("transformInvAgent caught it - writeDestiny", err)
        );

        return { function: "transformInvAgent ", result: written };
      } catch (error) {
        console.log("error", error);
        return { error: error };
      }
    }
  }
}

/************************************************************************ */

// npx babel-node src/sync/etl/transform/inv/agent/transform_agent.js
// transformInvAgent();

module.exports = {
  transformInvAgent
};
