import { extractRealAgents } from "./extract_real_agents";
import { extractRealAudit } from "./extract_real_audit";
import { extractRealBreaks } from "./extract_real_breaks";
import { extractRealCallEntry } from "./extract_real_callentry";
import { extractRealCalls } from "./extract_real_calls";
import { extractRealCdr } from "./extract_real_cdr";
import { extractRealQueueLog } from "./extract_real_queuelog";

const chalk = require("chalk");

let incoming_date = process.argv[2];

async function extractAllReal() {
  console.log("");
  console.log(
    chalk.hex("#4657bd")(
      "/*********************** START EXTRACT REAL *************************/"
    )
  );

  await extractRealAgents(incoming_date);
  await extractRealAudit(incoming_date);
  await extractRealBreaks(incoming_date);
  await extractRealCallEntry(incoming_date);

  await extractRealCalls(incoming_date);
  await extractRealCdr(incoming_date);
  await extractRealQueueLog(incoming_date);

  console.log("/***** END EXTRACT REAL *******/");
  console.log("");
}

/************************************************************************ */

// npx babel-node src/sync/etl/extract/real/extract-all-real.js
// extractAllReal();

module.exports = {
  extractAllReal
};
