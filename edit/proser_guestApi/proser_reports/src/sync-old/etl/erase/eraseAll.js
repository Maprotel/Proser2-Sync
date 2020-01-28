import * as pool from "../../../connectors/pool";
import { removeRowDataPacket } from "../../helpers/mysql-helper.js";
import moment from "moment";

// Read actual records
async function eraseTestData() {
  let result = null;

  let querySQL = `

  DELETE FROM AuxColor;
  DELETE FROM AuxHour;
  DELETE FROM AuxInfo;  
  DELETE FROM AuxInterval; 
  DELETE FROM AuxLine;

  DELETE FROM HcaAgent;
  DELETE FROM HcaQueue;
  DELETE FROM HcaExtension;
  DELETE FROM HcaOccasion;
  DELETE FROM HcxChange;

  DELETE FROM InvAgent;
  DELETE FROM InvAgentRole;
  DELETE FROM InvBreak;
  DELETE FROM InvCalendar;
  DELETE FROM InvCalendarDay;
  DELETE FROM InvCampaign;
  DELETE FROM InvClient;
  DELETE FROM InvQueue;
  DELETE FROM InvQueueConfig;
  DELETE FROM InvScale;
  DELETE FROM InvSchedule;
  DELETE FROM InvScheduleDay;
  DELETE FROM InvService;
  DELETE FROM InvSms;
  DELETE FROM InvSupervisor;

  DELETE FROM MainAudit;
  DELETE FROM MainCallEntry;
  DELETE FROM MainCdr;
  DELETE FROM MainQueueLog;

  DELETE FROM MainStoredQueries;

  DELETE FROM ProScheduleChange;
  DELETE FROM ProShowDisplay;


  DELETE FROM RealAudit;
  DELETE FROM RealCallEntry;
  DELETE FROM RealCdr;

  DELETE FROM RealCurrentAgents;
  DELETE FROM RealCurrentBreaks;
  DELETE FROM RealCurrentCalls;

  DELETE FROM RealHcaAgent;
  DELETE FROM RealHcaQueue;
  DELETE FROM RealQueueLog;

  DELETE FROM Role;
  DELETE FROM UserSelection;
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
    `***********  ALL TABLES ERASED ${pool.destinyReports.config.connectionConfig.database} ***********`
  );
  await eraseTestData();
  console.log("All Erased");
  process.exit(0);
}

erase();
