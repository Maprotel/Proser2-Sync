import * as pool from "../../../connectors/pool";
import { removeRowDataPacket } from "../../../helpers/mysql-helper";

const chalk = require( "chalk" );

// Main function
async function extractLocalTable ( tableName ) {
  let destinyTable = tableName;
  let originTable = tableName;

  console.log( `/*************/ Extracting ${ destinyTable } /*************/ ` );

  let records = await readOriginAllRecords( originTable ).catch( err =>
    console.log( `${ originTable } caught it - readOriginAllRecords`, err )
  );

  console.log( `${ destinyTable } records`, records.length );

  let extendedResult = records;

  let validation =
    Array.isArray( extendedResult ) && extendedResult.length > 0 ? true : false;

  if ( validation ) {
    try {
      let written = await writeDestiny( extendedResult, destinyTable ).catch(
        err => console.log( "extractLocalTable caught it - writeDestiny", err )
      );
      return `extractLocalTable ${ destinyTable } end`;
    } catch ( e ) {
      console.log( "e", e );
      return e;
    }
  } else {
    console.log( `********************************************` );
    console.log( `Empty result in: ${ originTable }` );
  }

  return "extractLocalTable ${destinyTable} end";
}

/************************************************************************ */

// Read actual records
async function readOriginAllRecords ( table ) {
  let result = null;

  let querySQL = `
  SELECT
  *
  FROM
  ${table }
  `;

  try {
    result = await pool.destinyInventory.query( querySQL );
  } catch ( error ) {
    result = { error: error };
  }

  return result;
}

/************************************************************************ */

// write processed records
async function writeDestiny ( data, current_table ) {
  let result = null;
  if ( data[ 0 ] !== undefined ) {
    return new Promise( ( resolve, reject ) => {
      let myfields = Object.keys( data[ 0 ] );

      let myRecords = data.map( x => {
        return Object.values( x );
      } );

      let updateFieldsArray = myfields.map( ( x, index ) => {
        return `${ x } = VALUE(${ x })`;
      } );

      let updateFields = updateFieldsArray;

      let querySQL = `INSERT INTO ${ current_table } (${ myfields }) values ?
    ON DUPLICATE KEY UPDATE ${updateFields }
    `;

      // Record in database
      resolve( pool.destinyReports.query( querySQL, [ myRecords ] ) );
      reject( `Error` );
    } );
  } else {
    return [];
  }
}

/************************************************************************ */

// execute
async function extractLocalInvToRep () {
  console.log( "" );
  console.log(
    chalk.hex( "#E5E510" )(
      "/*********************** START IMPORT LOCAL INV TO REPORTS *************************/"
    )
  );

  await extractLocalTable( "AuxColor" );
  await extractLocalTable( "AuxHour" );
  await extractLocalTable( "AuxInfo" );
  await extractLocalTable( "AuxInterval" );
  await extractLocalTable( "AuxLine" );

  await extractLocalTable( "HcxChange" );

  await extractLocalTable( "InvAgent" );
  await extractLocalTable( "InvAgentRole" );
  await extractLocalTable( "InvBreak" );
  await extractLocalTable( "InvCalendar" );
  await extractLocalTable( "InvCalendarDay" );
  await extractLocalTable( "InvCampaign" );
  await extractLocalTable( "InvClient" );
  await extractLocalTable( "InvQueue" );
  await extractLocalTable( "InvQueueConfig" );
  await extractLocalTable( "InvScale" );
  await extractLocalTable( "InvSchedule" );
  await extractLocalTable( "InvScheduleDay" );
  await extractLocalTable( "InvService" );
  await extractLocalTable( "InvSupervisor" );

  await extractLocalTable( "ProScheduleChange" );
  await extractLocalTable( "ProShowDisplay" );
}

// export
module.exports = {
  extractLocalInvToRep
};
