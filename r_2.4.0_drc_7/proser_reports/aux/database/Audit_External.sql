SELECT

      (SELECT DATE_FORMAT(min(cdr_calldate), '%Y-%m-%d')  FROM MainCdr) AS MinDate
    , (SELECT DATE_FORMAT(MAX(cdr_calldate), '%Y-%m-%d')  FROM MainCdr) AS MaxDate


    
    , (SELECT count(*)  FROM MainAudit) AS MainAudit
    , (SELECT count(*)  FROM MainCdr) AS MainCdr
    , (SELECT count(*)  FROM MainCallEntry) AS MainCallEntry
    , (SELECT count(*)  FROM MainQueueLog
    	WHERE 
        queuelog_event = 'COMPLETECALLER' 
        or  
        queuelog_event = 'COMPLETEAGENT') AS MainQueueLog
    
	, (SELECT count(*)  FROM InvAgent) AS InvAgent
    , (SELECT count(*)  FROM InvBreak) AS InvBreak
	, (SELECT count(*)  FROM InvQueue) AS InvQueue
	, (SELECT count(*)  FROM InvQueueConfig) AS InvQueueConfig
    , (SELECT count(*)  FROM InvCampaign) AS InvCampaign
    