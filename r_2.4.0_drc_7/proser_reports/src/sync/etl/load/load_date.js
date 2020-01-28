import { loadDay } from "../execute/execute-date";

import moment from "moment";

let today = moment().format( 'YYYY-MM-DD' )

loadDay( today )

/************************************************************************ */

// npx babel-node src/sync/etl/load/load_day.js
