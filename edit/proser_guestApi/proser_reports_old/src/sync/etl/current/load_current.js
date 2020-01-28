import * as pool from "../../../connectors/pool";

const moment = require("moment");
const colors = require("colors");

const {
  setIntervalAsync,
  clearIntervalAsync
} = require("set-interval-async/dynamic");

// EXTRACT MAIN
import { extractMainQueueLog } from "../extract/main/extract_queuelog";
import { extractMainAudit } from "../extract/main/extract_audit";
import { extractMainCallEntry } from "../extract/main/extract_callentry";
import { extractMainCdr } from "../extract/main/extract_cdr";

// EXTRACT INVENTORY
import { extractInvAgent } from "../extract/inv/extract_agent";
import { extractInvBreak } from "../extract/inv/extract_break";
import { extractInvCampaign } from "../extract/inv/extract_campaign";
import { extractInvQueue } from "../extract/inv/extract_queue";
import { extractInvQueueConfig } from "../extract/inv/extract_queueconfig";

// EXTRACT REAL
import { extractRealAgents } from "../extract/real/extract_realagents";
import { extractRealBreaks } from "../extract/real/extract_realbreaks";
import { extractRealCalls } from "../extract/real/extract_realcalls";

// TRANSFORM MAIN
import { transformMainAudit } from "../transform/main/audit/transform_audit";
import { transformMainCallEntry } from "../transform/main/callentry/transform_callentry";
import { transformMainCdr } from "../transform/main/cdr/transform_cdr";
import { transformMainCdrHca } from "../transform/main/cdr/transform_cdr_hca";

// TRANSFORM INVENTORY
import { transformInvAgent } from "../transform/inv/agent/transform_agent";
import { transformInvBreak } from "../transform/inv/break/transform_break";
import { transformInvQueue } from "../transform/inv/queue/transform_queue";
import { transformInvCampaign } from "../transform/inv/campaign/transform_campaign";

// TRANSFORM REAL
import { transformRealAgents } from "../transform/real/real-agents/transform_realagents";
import { transformRealBreaks } from "../transform/real/real-breaks/transform_realbreaks";
import { transformRealCalls } from "../transform/real/real-calls/transform_realcalls";

// UPDATE HCA
import { updateHcaAgent } from "../update/hca/update_hca_agent";
import { updateHcaQueue } from "../update/hca/update_hca_queue";

// UPDATE MAIN
import { updateMainAudit } from "../update/main/update_audit";
import { updateMainCalEntry } from "../update/main/update_callentry";

// UPDATE REAL
import { updateRealagents } from "../update/real/update_realagents";
import { updateRealbreaks } from "../update/real/update_realbreaks";
import { updateRealcalls } from "../update/real/update_realcalls";

/**************************************************************************** */

/** AUXILIAR FUNCTIONS */

async function delay(ms) {
  // return await for better async stack trace support in case of errors.
  return await new Promise(resolve => setTimeout(resolve, ms));
}

function now() {
  return {
    date: moment().format("YYYY-MM-DD"),
    time: moment().format("hh:mm:ss")
  };
}

function consoleInit() {
  console.clear();
  console.log("");
  console.log(
    "\x1b[33m%s\x1b[0m",
    "**********************************************"
  );
}

export async function checkConnection() {
  let query = `
  select id, user, host, db, command, time, state, info, progress
  from information_schema.processlist
  `;

  try {
    consoleInit();
    console.log("Conectando con servidor");
    let result = await pool.origin.query(query);
    return true;
  } catch (error) {
    console.log("Falla de conexión con el servidor", error);
    return false;
  }
}

export async function extractAll() {
  let msg = "No extraction";
  let today = now();
  let input_date = today.date;

  consoleInit();
  console.log("EXTRACT", today);
  console.log(
    "\x1b[33m%s\x1b[0m",
    "**********************************************"
  );

  try {
    Promise.all([
      extractMainQueueLog(input_date),
      extractMainAudit(input_date),
      extractMainCallEntry(input_date),
      extractMainCdr(input_date),
      extractInvAgent(input_date),
      extractInvBreak(input_date),
      extractInvCampaign(input_date),
      extractInvQueue(input_date),
      extractInvQueueConfig(input_date),
      extractRealAgents(input_date),
      extractRealBreaks(input_date),
      extractRealCalls(input_date)
    ]).then(extract => {
      msg = "Extracted";
      console.log("msg", msg);
    });
    return "Extracted";
  } catch (error) {
    console.log("error", error);
  }
}

export async function transformAll() {
  let msg = "No extraction";
  let today = now();
  let input_date = today.date;

  consoleInit();
  console.log("TRANSFORM", today);
  console.log(
    "\x1b[33m%s\x1b[0m",
    "**********************************************"
  );

  try {
    Promise.all([
      transformMainAudit(input_date),
      transformMainCallEntry(input_date),
      transformMainCdr(input_date),
      transformMainCdrHca(input_date),
      transformInvAgent(input_date),
      transformInvBreak(input_date),
      transformInvQueue(input_date),
      transformInvCampaign(input_date),
      transformRealAgents(input_date),
      transformRealBreaks(input_date),
      transformRealCalls(input_date)
    ]).then(extract => {
      msg = "Transform";
      console.log("msg", msg);
    });
    return "Transformed";
  } catch (error) {
    console.log("error", error);
  }
}

async function executeExtract() {
  let num = 0;
  while (true) {
    await new Promise(resolve => setTimeout(resolve, 10 * 1000));
    num += 1;
    consoleInit();
    let status = await checkConnection();
    console.log("print", num, status);
    if (status) {
      await extractAll();
    }
  }
}

async function executeTransform() {
  let num = 0;
  while (true) {
    await new Promise(resolve => setTimeout(resolve, 10 * 1000));
    num += 1;
    consoleInit();
    let status = await checkConnection();
    console.log("print", num, status);
    if (status) {
      await transformAll();
    }
  }
}

async function executeAll() {
  executeExtract();
  executeTransform();
}

executeAll();
