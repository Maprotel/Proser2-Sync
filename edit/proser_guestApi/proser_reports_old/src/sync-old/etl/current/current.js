import { loadInventory } from "../load/load_inventory";
import { loadMain } from "../load/load_main";
import { loadHca } from "../load/load_hca";
import { loadReal } from "../load/load_real";

const moment = require("moment");
const colors = require("colors");

const fast = process.env.UPDATE_FAST
  ? parseInt(process.env.UPDATE_FAST, 10)
  : 5000;
const medium = process.env.UPDATE_MEDIUM
  ? parseInt(process.env.UPDATE_MEDIUM, 10)
  : 20000;
const slow = process.env.UPDATE_SLOW
  ? parseInt(process.env.UPDATE_SLOW, 10)
  : 30000;
const very_slow = process.env.UPDATE_VERY_SLOW
  ? parseInt(process.env.UPDATE_VERY_SLOW, 10)
  : 3600000;

let times_inventory = 0;
let times_main = 0;
let times_hca = 0;
let times_realagents = 0;

let input_request = "all";

async function currentUpdate() {
  setInterval(() => {
    const todayDate = today().date;
    const todayTime = today().time;
    console.log(
      "\x1b[33m%s\x1b[0m",
      "**********************************************"
    );
    console.log("Date - Time", todayDate, todayTime);
    console.log("\x1b[33m%s\x1b[0m", "TIMES executeReal: ", times_realagents);
    console.log("\x1b[33m%s\x1b[0m", "TIMES times_main: ", times_main);
    executeReal(todayDate, input_request);
    executeMain(todayDate, input_request);
    executeInventory(todayDate, input_request);
    executeHca(todayDate, input_request);
    times_realagents = times_realagents + 1;
    times_main = times_main + 1;
    console.log(
      "\x1b[33m%s\x1b[0m",
      "**********************************************"
    );
  }, fast);
}

/** AUXILIAR FUNCTIONS */
function today() {
  return {
    date: moment().format("YYYY-MM-DD"),
    time: moment().format("hh:mm:ss")
  };
}

async function executeInventory(input_date, input_request) {
  let inv_inventory = await loadInventory(input_date, input_request);
  console.log(
    "////////////////// LOAD INVENTORY END ////////////////////".green
  );
  console.log("");
}

async function executeMain(input_date, input_request) {
  let inv_main = await loadMain(input_date, input_request);
  console.log("////////////////// LOAD MAIN END ////////////////////".green);
  console.log("");
}

async function executeHca(input_date, input_request) {
  let inv_hca = await loadHca(input_date, input_request);
  console.log("////////////////// LOAD HCA END ////////////////////".green);
  console.log("");
}

async function executeReal(input_date, input_request) {
  let inv_realagents = await loadReal(input_date, input_request);
  console.log("////////////////// LOAD REAL END ////////////////////".green);
  console.log("");
}

currentUpdate();
