import { extractInvAgent } from "../extract/inv/extract_agent";
import { extractInvBreak } from "../extract/inv/extract_break";
import { extractInvCampaign } from "../extract/inv/extract_campaign";
import { extractInvQueue } from "../extract/inv/extract_queue";
import { extractInvQueueConfig } from "../extract/inv/extract_queueconfig";

import { transformInvAgent } from "../transform/inv/agent/transform_agent";
import { transformInvBreak } from "../transform/inv/break/transform_break";
import { transformInvCampaign } from "../transform/inv/campaign/transform_campaign";
import { transformInvQueue } from "../transform/inv/queue/transform_queue";

import { extractLocalInvToRep } from "../local/extract_local";

import { updateHcaAgent } from "../update/hca/update_hca_agent";
import { updateHcaQueue } from "../update/hca/update_hca_queue";

import { transformHcaAgent } from "../transform/hca/hca-agent/transform_hca_agent";

import { extractMainAudit } from "../extract/main/extract_audit";
import { extractMainCallEntry } from "../extract/main/extract_callentry";
import { extractMainCdr } from "../extract/main/extract_cdr";
import { extractMainQueueLog } from "../extract/main/extract_queuelog";

import { transformMainAudit } from "../transform/main/audit/transform_audit";
import { transformMainCallEntry } from "../transform/main/callentry/transform_callentry";
import { transformMainCdr } from "../transform/main/cdr/transform_cdr";
import { transformMainCdrHca } from "../transform/main/cdr/transform_cdr_hca";

import { updateMainAudit } from "../update/main/update_audit";
import { updateMainCalEntry } from "../update/main/update_callentry";

import { extractRealAgents } from "../extract/real/extract_real_agents";
import { extractRealAudit } from "../extract/real/extract_real_audit";
import { extractRealBreaks } from "../extract/real/extract_real_breaks";
import { extractRealCallEntry } from "../extract/real/extract_real_callentry";
import { extractRealCalls } from "../extract/real/extract_real_calls";
import { extractRealCdr } from "../extract/real/extract_real_cdr";
import { extractRealQueueLog } from "../extract/real/extract_real_queuelog";

import { transformRealAgents } from "../transform/real/real-agents/transform_realagents";
import { transformRealBreaks } from "../transform/real/real-breaks/transform_realbreaks";
import { transformRealCalls } from "../transform/real/real-calls/transform_realcalls";

const chalk = require( "chalk" );

async function extractAll () {
  console.log( "" );
  console.log(
    chalk.hex( "#E50001" )(
      "/*********************** START ALL *************************/"
    )
  );

  console.log( "" );
  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START EXTRACT INV *************************/"
    )
  );

  await extractInvAgent();
  await extractInvBreak();
  await extractInvCampaign();
  await extractInvQueue();
  await extractInvQueueConfig();

  console.log( "/***** END EXTRACT INV *******/" );
  console.log( "" );

  console.log( "" );
  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START TRANSFORM INV *************************/"
    )
  );

  await transformInvAgent();
  await transformInvBreak();
  await transformInvCampaign();
  await transformInvQueue();

  console.log( "/***** END TRANSFORM INV *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START EXTRACT LOCAL *************************/"
    )
  );

  await extractLocalInvToRep();

  console.log( "/***** END EXTRACT LOCAL *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START UPDATE HCA *************************/"
    )
  );

  await updateHcaAgent();
  await updateHcaQueue();

  console.log( "/***** END UPDATE HCA *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START TRANSFORM HCA *************************/"
    )
  );

  await transformHcaAgent();

  console.log( "/***** END TRANSFORM HCA *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START EXTRACT MAIN *************************/"
    )
  );

  await extractMainAudit();
  await extractMainCallEntry();
  await extractMainQueueLog();
  await extractMainCdr();

  console.log( "/***** END EXTRACT MAIN *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START TRANSFORM MAIN *************************/"
    )
  );

  await transformMainAudit();
  await transformMainCallEntry();
  await transformMainCdr();
  await transformMainCdrHca();

  console.log( "/***** END TRANSFORM MAIN *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START UPDATE MAIN *************************/"
    )
  );

  await updateMainAudit();
  await updateMainCalEntry();

  console.log( "/***** END UPDATE MAIN *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START EXTRACT REAL *************************/"
    )
  );

  await extractRealAgents();
  await extractRealAudit();
  await extractRealBreaks();
  await extractRealCallEntry();

  await extractRealCalls();
  await extractRealCdr();
  await extractRealQueueLog();

  console.log( "/***** END EXTRACT REAL *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START TRANSFORM REAL *************************/"
    )
  );

  await transformRealAgents();
  await transformRealBreaks();
  await transformRealCalls();

  console.log( "/***** END TRANSFORM REAL *******/" );
  console.log( "" );

  console.log( "" );
  console.log(
    chalk.hex( "#E50001" )(
      "/*********************** END ALL *************************/"
    )
  );
}

async function runExceute () {
  extractAll();
  setInterval( () => {
    extractAll();
  }, 10000 );
}

/************************************************************************ */

// npx babel-node src/sync/etl/execute/execute-one.js
runExceute();

module.exports = {
  extractAll,
  runExceute
};