import * as pool from "../../../connectors/pool";
import { removeRowDataPacket } from "../../helpers/mysql-helper.js";
import moment from "moment";

// Read actual records
async function eraseTestData() {
  let result = null;

  let querySQL = `
  DELETE FROM InvAgent;
  DELETE FROM InvBreak;
  DELETE FROM InvQueue;
  DELETE FROM InvCampaign;

  DELETE FROM HcaAgent;
  DELETE FROM HcaQueue;

  DELETE FROM MainAudit;
  DELETE FROM MainCallEntry;
  DELETE FROM MainCdr;
  DELETE FROM MainQueueLog; 

  DELETE FROM RealCurrentAgents;
  DELETE FROM RealCurrentBreaks;
  DELETE FROM RealCurrentCalls;

  DELETE FROM RealAudit;
  DELETE FROM RealCdr;
  DELETE FROM RealCallEntry;
  DELETE FROM RealHcaAgent;
  DELETE FROM RealHcaQueue;
  DELETE FROM RealQueueLog;

  DELETE FROM ProShowDisplay;

  DELETE FROM ProScheduleChange;
  DELETE FROM MainStoredQueries;

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
    `***********  BASE TABLES ERASED ${pool.destinyReports.config.connectionConfig.database} ***********`
  );
  await eraseTestData();
  console.log("All Erased");
  process.exit(0);
}

erase();
