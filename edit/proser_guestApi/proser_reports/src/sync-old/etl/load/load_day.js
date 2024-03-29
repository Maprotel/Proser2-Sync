import { loadInventory } from "./load_inventory";
import { loadMain } from "./load_main";
import { loadHca } from "./load_hca";
import { loadReal } from "./load_real";
import { smsInformation } from "../sms/smsExecute";

import { extractAll } from "../local/extract_local";

import * as pool from "../../../connectors/pool";

const {
  setIntervalAsync,
  clearIntervalAsync
} = require("set-interval-async/dynamic");

// import * as moment from "moment";
const moment = require("moment");
const colors = require("colors");

colors.setTheme({
  silly: "rainbow",
  input: "grey",
  verbose: "cyan",
  prompt: "grey",
  info: "green",
  data: "grey",
  help: "cyan",
  warn: "yellow",
  debug: "blue",
  error: "red"
});

const fast = process.env.UPDATE_FAST
  ? parseInt(process.env.UPDATE_FAST, 10)
  : 5000;
const medium = process.env.UPDATE_MEDIUM
  ? parseInt(process.env.UPDATE_MEDIUM, 10)
  : 30000;
const slow = process.env.UPDATE_SLOW
  ? parseInt(process.env.UPDATE_SLOW, 10)
  : 30000;
const very_slow = process.env.UPDATE_VERY_SLOW
  ? parseInt(process.env.UPDATE_VERY_SLOW, 10)
  : 3600000;

// let today = moment().format("YYYY-MM-DD");

let input_date = today();
let input_request = process.argv[3];

// input_date === undefined ? (input_date = today()) : input_date;
input_request === undefined ? (input_request = "all") : "";

async function loadDay() {
  console.log("Hola");

  // console.clear();
  console.log(
    "\x1b[36m%s\x1b[0m",
    "**************** DAILY UPDATE ******************"
  );

  console.log("\x1b[36m%s\x1b[0m", "today", today(), typeof today());
  console.log("\x1b[36m%s\x1b[0m", "input_date", input_date, typeof input_date);
  console.log(
    "\x1b[36m%s\x1b[0m",
    "input_request",
    input_request,
    typeof input_request
  );

  console.log("Speed:".cyan);
  console.log(
    "very_slow",
    very_slow / 1000,
    "slow",
    slow / 1000,
    "medium",
    medium / 1000,
    "fast",
    fast / 1000
  );

  console.log("*************************************");
  console.log("");

  // await executeInventory(input_date, input_request);
  // await executeHca(input_date, input_request);
  // await executeMain(input_date, input_request);
  // await executeReal(input_date, input_request);

  setInterval(() => {
    let times_inventory;
    console.log(
      "\x1b[33m%s\x1b[0m",
      "TIMES executeInventory: ",
      times_inventory
    );
    executeInventory(input_date, input_request);
    times_inventory = times_inventory + 1;
  }, slow);

  setInterval(() => {
    let times_hca = 0;
    console.log("\x1b[33m%s\x1b[0m", "TIMES executeHca; ", times_hca);
    executeHca(today(), input_request);
    times_hca = times_hca + 1;
  }, fast);

  setInterval(() => {
    let times_main = 0;
    console.log("\x1b[33m%s\x1b[0m", "TIMES executeMain: ", times_main);
    executeMain(today(), input_request);
    times_main = times_main + 1;
  }, medium);

  setInterval(() => {
    let times_realagents;
    console.log("\x1b[33m%s\x1b[0m", "TIMES executeReal: ", times_realagents);
    executeReal(today(), input_request);
    times_realagents = times_realagents + 1;
  }, medium);
}

async function executeInventory(input_date, input_request) {
  input_date = today();

  let inv_inventory = await loadInventory(input_date, input_request);
  let local_inventory = await extractAll();
  let getSms = await smsInformation();
  console.log("SMS EXECUTE", getSms);
  console.log(
    "////////////////// LOAD INVENTORY END ////////////////////".green
  );
  console.log("");
}

async function executeMain(input_date, input_request) {
  input_date = today();
  let inv_main = await loadMain(today(), input_request);
  console.log("////////////////// LOAD MAIN END ////////////////////".green);
  console.log("");
}

async function executeHca(input_date, input_request) {
  input_date = today();
  let inv_hca = await loadHca(input_date, input_request);
  console.log("////////////////// LOAD HCA END ////////////////////".green);
  console.log("");
}

async function executeReal(input_date, input_request) {
  input_date = today();
  let inv_realagents = await loadReal(input_date, input_request);
  console.log("////////////////// LOAD REAL END ////////////////////".green);
  console.log("");
}

function today() {
  let input_date = process.argv[2];
  input_date === undefined
    ? (input_date = moment().format("YYYY-MM-DD"))
    : input_date;
  return input_date;
}

async function executeLoadDay() {
  let result = null;
  let querySQL = `SELECT VERSION()`;

  try {
    console.log("**** LOAD DAY ********");
    result = await pool.origin.query(querySQL);
    console.log("result", result);
    if (result.length > 0) {
      loadDay();
    } else {
      console.log("No Origin connection");
    }
  } catch (error) {
    result = { error: error };
    console.log("Error load-day", error);
  }

  return result;
}

executeLoadDay();
