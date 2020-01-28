import * as pool from "../../../connectors/pool";
import { removeRowDataPacket } from "../../helpers/mysql-helper.js";
import moment from "moment";

// Read actual records
async function eraseTestData() {
  let result = null;

  let querySQL = `

  DELETE FROM MainAudit;
  DELETE FROM MainCallEntry;
  DELETE FROM MainCdr;
  DELETE FROM MainQueueLog;

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
    `***********  MAIN TABLES ERASED ${pool.destinyReports.config.connectionConfig.database} ***********`
  );
  await eraseTestData();
  console.log("All Erased");
  process.exit(0);
}

erase();
