import * as pool from "../../../connectors/pool";
import { removeRowDataPacket } from "../../helpers/mysql-helper.js";
import moment from "moment";

// Read actual records
async function eraseTestData() {
  let result = null;

  let querySQL = `

  DELETE FROM HcaAgent;
  DELETE FROM HcaQueue;
  DELETE FROM HcxChange;

  `;

  try {
    result = await pool.destinyReports.query(querySQL);
  } catch (error) {
    result = { error: error };
    console.log("error", error);
  }

  return result;
}

async function erase() {
  console.clear();
  console.log(
    `***********  HCA TABLES ERASED ${pool.destinyReports.config.connectionConfig.database} ***********`
  );
  await eraseTestData();
  console.log("All Erased");
  process.exit(0);
}

erase();
