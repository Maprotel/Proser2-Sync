import * as pool from "../../../../connectors/pool";
import moment from "moment";

const start_date = moment().format("YYYY-MM-DD");
const database = process.env.REPORTS_PROSER_DB;

// Read actual cdr records
async function deleteOldRecords(table, date_field, start_date) {
  let result;

  let querySQL = `
    DELETE FROM ${database}.${table} WHERE ${date_field} <= '${start_date}'
    `;

  console.log("querySQL", querySQL);

  let countSQL = `
    SELECT COUNT(*) AS count FROM ${table} WHERE ${date_field} <= '${start_date}'
    `;

  try {
    let count = await pool.destinyReports.query(countSQL);
    console.log("Total  " + table + " " + JSON.stringify(count));

    result = await pool.destinyReports.query(querySQL);
    return result;
  } catch (error) {
    result = {
      status: "error",
      msg: error
    };
    return result;
  }
}

async function executeDelete() {
  console.log("Starting Real delete");

  Promise.all([
    deleteOldRecords("RealAudit", "audit_date", start_date),
    deleteOldRecords("RealCallEntry", "callentry_date", start_date),
    deleteOldRecords("RealCdr", "cdr_date", start_date),
    deleteOldRecords("RealCurrentAgents", "rca_date", start_date),
    deleteOldRecords("RealCurrentBreaks", "rcb_date", start_date),
    deleteOldRecords("RealCurrentCalls", "rcc_date", start_date),
    deleteOldRecords("RealQueueLog", "queuelog_date", start_date),
    deleteOldRecords("RealHcaAgent", "hca_agent_date", start_date)
  ]).then(result => {
    let RealAudit = result[0];
    let RealCallEntry = result[1];
    let RealCdr = result[2];
    let RealCurrentAgents = result[2];
    let RealCurrentBreaks = result[2];
    let RealCurrentCalls = result[2];
    let RealQueueLog = result[2];
  });
}

executeDelete();
