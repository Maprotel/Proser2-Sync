import { updateHcaAgent } from "../update/hca/update_hca_agent";
import { updateHcaQueue } from "../update/hca/update_hca_queue";

const chalk = require("chalk");

async function executeHca() {
  console.log("");
  console.log(
    chalk.hex("#E5E510")(
      "/*********************** START INV *************************/"
    )
  );

  await updateHcaAgent();
  await updateHcaQueue();

  console.log(
    chalk.hex("#E5E510")(
      "/*********************** END INV *************************/"
    )
  );
  console.log("");
}

/************************************************************************ */

// npx babel-node src/sync/etl/execute/execute_hca.js
// executeHca();

module.exports = {
  executeHca
};
