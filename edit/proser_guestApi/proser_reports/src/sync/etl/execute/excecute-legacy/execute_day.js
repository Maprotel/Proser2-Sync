import { executeAllInv } from "./execute_inv";
import { executeHca } from "./execute_hca";
import { executeAllMain } from "./execute_main";
import { executeAllReal } from "./execute_real";

const chalk = require("chalk");

async function executeDay() {
  console.log("");
  console.log(
    chalk.hex("#E50001")(
      "/*********************** START ALL *************************/"
    )
  );

  await executeAllInv();
  await executeHca();
  await executeAllMain();
  await executeAllReal();

  console.log(
    chalk.hex("#E50001")(
      "/*********************** END ALL *************************/"
    )
  );
  console.log("");

  return;
}

/************************************************************************ */

// npx babel-node src/sync/etl/execute/execute_day.js
executeDay();

module.exports = {
  executeDay
};
