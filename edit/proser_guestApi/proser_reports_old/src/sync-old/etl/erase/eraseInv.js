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

  `;

  // return new Promise((resolve, reject) => {
  //   resolve(pool.destiny.query(querySQL));
  //   reject(`Error`);
  // });

  try {
    result = await pool.destiny.query(querySQL);
  } catch (error) {
    result = { error: error };
  }

  return result;
}

async function erase() {
  console.clear();
  console.log("***********  BORRANDO TABLAS INV ***********");
  await eraseTestData();
  console.log("Todo borrado");
  process.exit(0);
}


erase();
