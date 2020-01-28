import { extractAllReal } from "../extract/real/extract-all-real";

const chalk = require("chalk");

async function executeAllReal() {
  console.log("");
  console.log(
    chalk.hex("#E5E510")(
      "/*********************** START REAL *************************/"
    )
  );

  await extractAllReal();

  console.log(
    chalk.hex("#E5E510")(
      "/*********************** END REAL *************************/"
    )
  );
  console.log("");
}

/************************************************************************ */

// npx babel-node src/sync/etl/execute/execute_real.js
// executeAllReal();

module.exports = {
  executeAllReal
};
