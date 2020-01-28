import * as pool from "../../../../connectors/pool";
import { removeRowDataPacket } from "../../../helpers/mysql-helper.js";
import moment from "moment";

// write processed records
async function writeDestiny(data, current_table) {
  let result = null;

  if (data[0] !== undefined) {
    let myfields = Object.keys(data[0]);

    let myRecords = data.map(x => {
      return Object.values(x);
    });

    let updateFieldsArray = myfields.map((x, index) => {
      return `${x} = VALUE(${x})`;
    });

    let updateFields = updateFieldsArray;

    let querySQL = `
        INSERT INTO ${current_table} (${myfields}) values ?
        ON DUPLICATE KEY UPDATE ${updateFields}
      `;

    try {
      result = pool.destinyInventory.query(querySQL, [myRecords]);
    } catch (error) {
      result = { error: error };
    }
    return result;
  }
}

// Read actual records
async function readOriginAllRecords(table) {
  let result = null;

  let querySQL = `
  SELECT
  *
  FROM
  ${table}
  `;

  try {
    result = await pool.origin.query(querySQL);
  } catch (error) {
    result = { error: error };
  }

  return result;
}

module.exports = {
  writeDestiny,
  readOriginAllRecords
};
