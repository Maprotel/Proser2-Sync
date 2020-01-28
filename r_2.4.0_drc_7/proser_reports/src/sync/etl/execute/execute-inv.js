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


let input_date = process.argv[ 2 ]
let incoming_date = input_date === '' ? '' : process.argv[ 2 ];

const chalk = require( "chalk" );

async function executeAllInv () {
  console.log( "" );
  console.log(
    chalk.hex( "#E5E510" )(
      "/*********************** START INV *************************/"
    )
  );
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
    chalk.hex( "#E5E510" )(
      "/*********************** END INV *************************/"
    )
  );
  console.log( "" );
}

/************************************************************************ */

// npx babel-node src/sync/etl/execute/execute_inv.js
executeAllInv();

module.exports = {
  executeAllInv
};
