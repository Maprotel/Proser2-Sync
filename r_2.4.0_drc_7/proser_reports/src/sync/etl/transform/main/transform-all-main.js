import { transformMainAudit } from "./audit/transform_audit";
import { transformMainCallEntry } from "./callentry/transform_callentry";
import { transformMainCdr } from "./cdr/transform_cdr";
import { transformMainCdrHca } from "./cdr/transform_cdr_hca";

let incoming_date = process.argv[2];

const chalk = require("chalk");

async function transformAllMain() {
  console.log("");
  console.log(
    chalk.hex("#4657bd")(
      "/*********************** START TRANSFORM MAIN *************************/"
    )
  );

  await transformMainAudit(incoming_date);
  await transformMainCallEntry(incoming_date);
  await transformMainCdr(incoming_date);
  await transformMainCdrHca(incoming_date);

  console.log("/***** END TRANSFORM MAIN *******/");
  console.log("");
}

/************************************************************************ */

// npx babel-node src/sync/etl/transform/main/transform-all-main.js
// transformAllMain();

module.exports = {
  transformAllMain
};
