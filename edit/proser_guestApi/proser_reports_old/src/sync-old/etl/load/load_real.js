import { extractRealAgents } from "../extract/real/extract_realagents";
import { transformRealAgents } from "../transform/real/real-agents/transform_realagents";
import { updateRealagents } from "../update/real/update_realagents";

import { extractRealBreaks } from "../extract/real/extract_realbreaks";
import { transformRealBreaks } from "../transform/real/real-breaks/transform_realbreaks";
import { updateRealbreaks } from "../update/real/update_realbreaks";

import { extractRealCalls } from "../extract/real/extract_realcalls";
import { transformRealCalls } from "../transform/real/real-calls/transform_realcalls";
import { updateRealcalls } from "../update/real/update_realcalls";

import { extractRealAudit } from "../extract/main-real/extract_real-audit";
import { extractRealCallEntry } from "../extract/main-real/extract_real_callentry";
import { extractRealCdr } from "../extract/main-real/extract_real_cdr";
import { extractRealQueueLog } from "../extract/main-real/extract_real_queuelog";

import { transformRealAudit } from "../transform/main-real/audit/transform_audit";
import { transformRealCallEntry } from "../transform/main-real/callentry/transform_callentry";
import { transformRealCdr } from "../transform/main-real/cdr/transform_cdr";
import { transformRealCdrHca } from "../transform/main-real/cdr/transform_cdr_hca";

import { updateRealAudit } from "../update/main-real/update_real_audit";
import { updateRealCallEntry } from "../update/main-real/update_real_callentry";

async function loadReal(input_date, input_request) {
  // console.clear();

  try {
    if (input_request === "RealQueuelog" || input_request === "all") {
      let inv_queuelog = await extractRealQueueLog(input_date);
      console.log("inv_queuelog", inv_queuelog);
      console.log("------------------------------------------------");
      console.log("");
    }

    if (input_request === "RealAudit" || input_request === "all") {
      let inv_audit = await extractRealAudit(input_date);
      console.log("upd_audit", upd_audit);
      let tra_audit = await transformRealAudit(input_date);
      console.log("inv_audit", inv_audit);
      let upd_audit = await updateRealAudit(input_date);
      console.log("tra_audit", tra_audit);
      console.log("------------------------------------------------");
      console.log("");
    }

    if (input_request === "RealCallEntry" || input_request === "all") {
      let inv_call_entry = await extractRealCallEntry(input_date);
      console.log("inv_call_entry", inv_call_entry);
      let up_call_entry = await updateRealCallEntry(input_date);
      console.log("up_call_entry", up_call_entry);
      let tra_call_entry = await transformRealCallEntry(input_date);
      console.log("tra_call_entry", tra_call_entry);
      console.log("------------------------------------------------");
      console.log("");
    }

    if (input_request === "RealCdr" || input_request === "all") {
      let inv_cdr = await extractRealCdr(input_date);
      console.log("inv_cdr", inv_cdr);
      let tra1_cdr = await transformRealCdr(input_date);
      console.log("tra_cdr", tra1_cdr);
      let tra2_cdr = await transformRealCdrHca(input_date);
      console.log("tra_cdr", tra2_cdr);

      console.log("------------------------------------------------");
      console.log("");
    }

    if (input_request === "RealCalls" || input_request === "all") {
      let inv_realcalls = await extractRealCalls(input_date);
      console.log("inv_realcalls", inv_realcalls);
      let tra_realcalls = await transformRealCalls(input_date);
      console.log("tra_realcalls", tra_realcalls);
      let up_realcalls = await updateRealcalls(input_date);
      console.log("up_realcalls", up_realcalls);
      console.log("------------------------------------------------");
      console.log("");
    }

    if (input_request === "RealBreaks" || input_request === "all") {
      let inv_realbreaks = await extractRealBreaks(input_date);
      console.log("inv_realbreaks", inv_realbreaks);
      let tra_realbreaks = await transformRealBreaks(input_date);
      console.log("tra_realbreaks", tra_realbreaks);
      let up_realbreaks = await updateRealbreaks(input_date);
      console.log("up_realbreaks", up_realbreaks);
      console.log("------------------------------------------------");
      console.log("");
    }

    if (input_request === "RealAgents" || input_request === "all") {
      let inv_realagents = await extractRealAgents(input_date);
      console.log("inv_realagents", inv_realagents);
      let tra_realagents = await transformRealAgents(input_date);
      console.log("tra_realagents", tra_realagents);
      let up_realagents = await updateRealagents(input_date);
      console.log("up_realagents", up_realagents);

      console.log("------------------------------------------------");
      console.log("");
    }

    console.log("************** End load REAL **************");
  } catch (e) {
    console.log("error", e);
    // process.exit(1);
  }
}

module.exports = {
  loadReal
};
