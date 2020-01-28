SELECT

      (SELECT DATE_FORMAT(min(calldate), '%Y-%m-%d')  FROM asteriskcdrdb.cdr) AS CdrDate
	, (SELECT DATE_FORMAT(MAX(calldate), '%Y-%m-%d')  FROM asteriskcdrdb.cdr) AS MaxDate
    
    , (SELECT count(*)  FROM call_center.audit) AS MainAudit
    , (SELECT count(*)  FROM asteriskcdrdb.cdr) AS MainCdr
    , (SELECT count(*)  FROM call_center.call_entry) AS MainCallEntry
    , (SELECT count(*)  FROM asterisk.queuelog 
		WHERE 
        event = 'COMPLETECALLER' 
        or  
        event = 'COMPLETEAGENT' ) AS MainQueueLog
    
	, (SELECT count(*)  FROM call_center.agent) AS InvAgent
    , (SELECT count(*)  FROM call_center.break) AS InvBreak
	, (SELECT count(*)  FROM call_center.queue_call_entry) AS InvQueue
	, (SELECT count(*)  FROM asterisk.queues_config) AS InvQueueConfig
    , (SELECT count(*)  FROM call_center.campaign_entry) AS InvCampaign
    