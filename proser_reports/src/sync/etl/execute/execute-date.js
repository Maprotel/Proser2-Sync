import * as pool from "../../../connectors/pool";
import { removeRowDataPacket } from "../../../helpers/mysql-helper.js";
import moment from "moment";

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

// import { transformHcaAgent } from "../transform/hca/hca-agent/transform_hca_agent";

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

import { exportSms } from "../sms/smsExecute"


let input_date = process.argv[ 2 ]
let incoming_date = input_date === '' ? '' : process.argv[ 2 ];
const chalk = require( "chalk" );

let min_date = executeMinOriginDate()

async function extractAll ( incoming_date ) {
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

  await extractInvAgent( input_date );
  await extractInvBreak( input_date );
  await extractInvCampaign( input_date );
  await extractInvQueue( input_date );
  await extractInvQueueConfig( input_date );

  console.log( "/***** END EXTRACT INV *******/" );
  console.log( "" );

  console.log( "" );
  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START TRANSFORM INV *************************/"
    )
  );

  await transformInvAgent( input_date );
  await transformInvBreak( input_date );
  await transformInvCampaign( input_date );
  await transformInvQueue( input_date );

  console.log( "/***** END TRANSFORM INV *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START EXTRACT LOCAL *************************/"
    )
  );

  await extractLocalInvToRep( input_date );

  console.log( "/***** END EXTRACT LOCAL *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START UPDATE HCA *************************/"
    )
  );

  await updateHcaAgent( input_date );
  await updateHcaQueue( input_date );

  console.log( "/***** END UPDATE HCA *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START TRANSFORM HCA *************************/"
    )
  );

  // await transformHcaAgent( input_date );

  console.log( "/***** END TRANSFORM HCA *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START EXTRACT MAIN *************************/"
    )
  );

  await extractMainAudit( input_date );
  await extractMainCallEntry( input_date );
  await extractMainQueueLog( input_date );
  await extractMainCdr( input_date );

  console.log( "/***** END EXTRACT MAIN *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START TRANSFORM MAIN *************************/"
    )
  );

  await transformMainAudit( input_date );
  await transformMainCallEntry( input_date );
  await transformMainCdr( input_date );
  await transformMainCdrHca( input_date );

  console.log( "/***** END TRANSFORM MAIN *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START UPDATE MAIN *************************/"
    )
  );

  await updateMainAudit( input_date );
  await updateMainCalEntry( input_date );

  console.log( "/***** END UPDATE MAIN *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START EXTRACT REAL *************************/"
    )
  );

  await extractRealAgents( input_date );
  await extractRealAudit( input_date );
  await extractRealBreaks( input_date );
  await extractRealCallEntry( input_date );

  await extractRealCalls( input_date );
  await extractRealCdr( input_date );
  await extractRealQueueLog( input_date );

  console.log( "/***** END EXTRACT REAL *******/" );
  console.log( "" );

  console.log(
    chalk.hex( "#4657bd" )(
      "/*********************** START TRANSFORM REAL *************************/"
    )
  );

  await transformRealAgents( input_date );
  await transformRealBreaks( input_date );
  await transformRealCalls( input_date );

  console.log( "/***** END TRANSFORM REAL *******/" );
  console.log( "" );


  await exportSms( input_date )

  console.log( "" );
  console.log(
    chalk.hex( "#E50001" )(
      "/*********************** END ALL *************************/"
    )
  );
}


// Find minimun date in Origin Cdr
async function executeMinOriginDate () {
  let result = null;
  let querySQL = `SELECT min(calldate) as min_date from asteriskcdrdb.cdr`;

  try {
    console.log( "MinDate in CDR" );
    let getQuery = await pool.origin.query( querySQL );
    let preresult = removeRowDataPacket( getQuery );
    let longDate = Array.isArray( preresult ) && preresult.length > 0 ? preresult[ 0 ].min_date : '';
    result = moment( longDate ).format( 'YYYY-MM-DD' )
    return result
  } catch ( error ) {
    result = { error: error };
    console.log( "Error load-day", error );
  }
}

// Run endless requests
async function runExecute ( incoming_date ) {
  extractAll( incoming_date );
  setInterval( () => {
    extractAll( incoming_date );
  }, 5000 );
}

// Run only one day
async function loadOneDay ( incoming_date ) {
  let result = null;
  let querySQL = `SELECT VERSION()`;

  try {
    console.log( "**** LOAD DAY ********" );
    result = await pool.origin.query( querySQL );
    console.log( "result", result );
    if ( result.length > 0 ) {
      runExecute( incoming_date );
    } else {
      console.log( "No Origin connection" );
    }
  } catch ( error ) {
    result = { error: error };
    console.log( "Error load-day", error );
  }
}

// Run historic
async function loadHistory ( incoming_date, min_date ) {
  let result = null;

  try {
    console.log( `**** HISTORIC ${ incoming_date } -- ${ min_date }  ********` );
    setInterval( () => {
      extractAll( incoming_date );
      incoming_date = previousDate( incoming_date );
    }, 10000 );

  } catch ( error ) {
    result = { error: error };
    console.log( "Error load-day", error );
  }
}

// Get previous date
function previousDate ( initial_date ) {
  let formated_date = moment().format( "YYYY-MM-DD" );
  let startdate = moment( initial_date );
  let previous_date = startdate.subtract( 1, "days" );
  formated_date = startdate.format( "YYYY-MM-DD" );
  return formated_date;
}

/************************************************************************ */

// npx babel-node src/sync/etl/execute/execute-date.js

module.exports = {
  extractAll,
  loadOneDay,
  loadHistory,
};
