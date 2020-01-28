import { loadOneDay } from "../execute/execute-date";

import moment from "moment";

let today = moment().format( 'YYYY-MM-DD' )

loadOneDay( today )


/************************************************************************ */

// npx babel-node src/sync/etl/load/load_day.js
