import { transformInvAgent } from "./agent/transform_agent";
import { transformInvBreak } from "./break/transform_break";
import { transformInvCampaign } from "./campaign/transform_campaign";
import { transformInvQueue } from "./queue/transform_queue";

const chalk = require("chalk");

async function transformAllInv() {
  console.log("");
  console.log(
    chalk.hex("#4657bd")(
      "/*********************** START TRANSFORM INV *************************/"
    )
  );

  await transformInvAgent();
  await transformInvBreak();
  await transformInvCampaign();
  await transformInvQueue();

  console.log("/***** END TRANSFORM INV *******/");
  console.log("");
}

/************************************************************************ */

// npx babel-node src/sync/etl/extract/inv/extract-all-inv.js
// transformAllInv();

module.exports = {
  transformAllInv
};
