import { extractInvAgent } from "./extract_agent";
import { extractInvBreak } from "./extract_break";
import { extractInvCampaign } from "./extract_campaign";
import { extractInvQueue } from "./extract_queue";
import { extractInvQueueConfig } from "./extract_queueconfig";

async function extractAllInv() {
  console.log("/***** START EXTRACT INV *******/");

  extractInvAgent();
  extractInvBreak();
  extractInvCampaign();
  extractInvQueue();
  extractInvQueueConfig();

  console.log("/***** END EXTRACT INV *******/");
  console.log("");
}

extractAllInv();
