import { extractMainAudit } from "./extract_audit";
import { extractMainCallEntry } from "./extract_callentry";
import { extractMainCdr } from "./extract_cdr";
import { extractMainQueueLog } from "./extract_queuelog";

const chalk = require("chalk");

let incoming_date = process.argv[2];

async function extractAllMain() {
  console.log("");
  console.log(
    chalk.hex("#4657bd")(
      "/*********************** START EXTRACT MAIN *************************/"
    )
  );

  await extractMainAudit(incoming_date);
  await extractMainCallEntry(incoming_date);
  await extractMainCdr(incoming_date);
  await extractMainQueueLog(incoming_date);

  console.log("/***** END EXTRACT MAIN *******/");
  console.log("");
}

/************************************************************************ */

// npx babel-node src/sync/etl/extract/main/extract-all-main.js
// extractAllMain();

module.exports = {
  extractAllMain
};
