import { extractInvAgent } from "./extract_agent";
import { extractInvBreak } from "./extract_break";
import { extractInvCampaign } from "./extract_campaign";
import { extractInvQueue } from "./extract_queue";
import { extractInvQueueConfig } from "./extract_queueconfig";

const chalk = require("chalk");

async function extractAllInv() {
  console.log("");
  console.log(
    chalk.hex("#4657bd")(
      "/*********************** START EXTRACT INV *************************/"
    )
  );

  await extractInvAgent();
  await extractInvBreak();
  await extractInvCampaign();
  await extractInvQueue();
  await extractInvQueueConfig();

  console.log("/***** END EXTRACT INV *******/");
  console.log("");
}

/************************************************************************ */

// npx babel-node src/sync/etl/extract/inv/extract-all-inv.js
// extractAllInv();

module.exports = {
  extractAllInv
};
