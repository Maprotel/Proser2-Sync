import * as pool from "../../../connectors/pool";
import { removeRowDataPacket } from "../../../helpers/mysql-helper.js";
import moment from "moment";

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


let input_date = process.argv[ 2 ]
let incoming_date = input_date === '' ? '' : process.argv[ 2 ];
const chalk = require( "chalk" );

let min_date = executeMinOriginDate()


async function extractMain ( incoming_date ) {
  console.log( "" );
  console.log(
    chalk.hex( "#E50001" )(
      "/*********************** START ALL *************************/"
    )
  );
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
  extractMain( incoming_date );
  setInterval( () => {
    extractMain( incoming_date );
  }, 3000 );
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
    console.log( "**** HISTORIC ********" );
    setInterval( () => {
      console.log( `**** ${ incoming_date } -- ${ min_date }  ********` );
      extractMain( incoming_date );
      incoming_date = previousDate( incoming_date );
    }, 5000 );

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

// npx babel-node src/sync/etl/execute/execute-main.js

runExecute( incoming_date )

module.exports = {
  extractMain,
  loadOneDay,
  loadHistory,
};
