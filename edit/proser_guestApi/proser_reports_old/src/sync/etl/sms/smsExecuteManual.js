import * as pool from "../../../connectors/pool";
import fs from "fs";
import moment from "moment";
const shell = require("shelljs");

require(`dotenv`).config();

// if (process.env.NODE_ENV !== `development`) {
//   require(`dotenv`).config();
// }

/******************************************************************** */

export async function smsInformation() {
  let result = {};

  const idealTime = process.env.CDR_SERVICE_IDEAL_TIME;
  const filePath = process.env.DESTINY_FILE_PATH_SMS_LOCAL;
  const date = moment().format("YYYY-MM-DD");

  let query = `
-- ---------------------------------------------------------------
-- FIELDS
SELECT


DATE_FORMAT(now(), "%Y-%m-%d") as Fecha
,TIME(now()) as Hora
,inv_queue_sms_name as Cola
,SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end) AS Recibidas
,SUM(case when callentry_status = 'terminada' then 1 else 0 end) AS Atendidas
,CONCAT(FORMAT((SUM(case when (callentry_status = 'terminada' AND callentry_duration_sec_wait <= ${idealTime}) then 1 else 0 end)/
SUM(case when (callentry_status = 'abandonada' OR callentry_status = 'terminada' )then 1 else 0 end)) * 100, 2), '%') AS NS
,CONCAT(inv_scale_green, '%') as Meta
-- ---------------------------------------------------------------
-- TABLES & JOINS

FROM

RealCallEntry
LEFT OUTER JOIN InvAgent
ON callentry_agent_id = inv_agent_id

LEFT OUTER JOIN InvQueue
ON callentry_queue_id = inv_queue_id

LEFT OUTER JOIN InvScale
ON JSON_EXTRACT(inv_queue_system_json, "$.scale.id") = inv_scale_id

-- ---------------------------------------------------------------
-- CONDITIONS
WHERE 1

-- TIME AND DATE
AND DATE(callentry_datetime_init)= '${date}'



GROUP BY inv_queue_sms_name 

-- ---------------------------------------------------------------
-- END
`;

  // console.log(query);

  try {
    let resultPre = await pool.destiny.query(query);
    console.log(resultPre);
    let file = resultPre.map(x => {
      let temp = JSON.stringify(x);
      let content = temp.replace(/["{}]/g, "");
      let path = `${filePath}${x.Cola}.txt`;
     await fs.writeFile(path, content, error => {
        if (error) {
          throw error;
        }
        console.log("El archivo ha sido creado exitosamente en: ", path);
      });
      return path;
    });

    copySms();

    result = {
      file,
      resultPre
    };

    // console.log("RESULT", result);
  } catch (error) {
    result = { error: error };
  }

  return result;
}

async function copySms() {
  try {
    var result = await shell.exec(
      `cp -a /var/www/html/proser_reports/src/public/sms/. /mnt/`
    );
    return result;
  } catch (error) {
    shell.echo("error", error);
  }
}

async function test() {
  let getSms = await smsInformation();
  // console.log("getSms", getSms);
}

test();
