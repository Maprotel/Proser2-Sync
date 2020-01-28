import { extractAllMain } from "../extract/main/extract-all-main";
import { transformAllMain } from "../transform/main/transform-all-main";

const chalk = require("chalk");

async function executeAllMain() {
  console.log("");
  console.log(
    chalk.hex("#E5E510")(
      "/*********************** START MAIN *************************/"
    )
  );

  await extractAllMain();
  await transformAllMain();

  console.log(
    chalk.hex("#E5E510")(
      "/*********************** END MAIN *************************/"
    )
  );
  console.log("");
}

/************************************************************************ */

// npx babel-node src/sync/etl/execute/execute_main.js
// executeAllMain();

module.exports = {
  extractAllMain
};
