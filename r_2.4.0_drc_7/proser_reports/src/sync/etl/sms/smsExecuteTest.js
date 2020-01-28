import * as pool from "../../../connectors/pool";
import fs from "fs";
import moment from "moment";

require(`dotenv`).config();

if (process.env.NODE_ENV !== `development`) {
  require(`dotenv`).config();
}

/******************************************************************** */

export async function smsInformation() {
  let result = {};

  const idealTime = process.env.CDR_SERVICE_IDEAL_TIME;

  const filePathLocal = '/var/www/html/proser_reports/src/public/sms/' // process.env.DESTINY_FILE_PATH_SMS_LOCAL;
  const filePathExternal = '/mnt/' // process.env.DESTINY_FILE_PATH_SMS_EXTERNAL;
  const date = moment().format("YYYY-MM-DD");

  console.log("idealTime", idealTime);

  try {
    let pathLocal = `${filePathLocal}anaconda.txt`;
    let pathExternal = `${filePathExternal}anaconda.txt`;

    console.log("/*************** SMS TEST *********************/");
    console.log("pathLocal", pathLocal);
    console.log("pathExternal", pathExternal);

    fs.writeFile(pathLocal, "content", error => {
      if (error) {
        throw error;
      }
      console.log("El archivo ha sido creado exitosamente en LOCAL");
    });

    fs.writeFile(pathExternal, "content", error => {
      if (error) {
        throw error;
      }
      console.log("El archivo ha sido creado exitosamente en EXTERNAL");
    });

    console.log("/*************** SMS TEST end *********************/");

    result = {
      local: pathLocal,
      external: pathExternal
    };

    return result;

  } catch (error) {
    result = { error: error };
  }

  return result;
}

async function test() {
  let getSms = await smsInformation();
}

test();
