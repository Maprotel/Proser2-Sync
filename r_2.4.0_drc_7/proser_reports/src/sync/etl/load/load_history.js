import { loadHistory } from "../execute/execute-history";

import moment from "moment";


let today = moment().format( 'YYYY-MM-DD' )


loadHistory()


/************************************************************************ */

// npx babel-node src/sync/etl/load/load_history.js
