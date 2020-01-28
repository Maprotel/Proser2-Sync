-- ---------------------------------------------------------------
-- FIELDS
SELECT

-- TIME & INTERVAL
now() as now
,1

,cdr_id as cdr_id
,cdr_uniqueid as cdr_uniqueid
,cdr_agent_id as agent_id
,inv_agent_name as agent_name
,JSON_UNQUOTE(JSON_EXTRACT(cdr_people_json, "$[0].agent[0].extension")) as agent_extension
,IF(cdr_dcontext = 'from-internal-xfer', 'xfer', '') as agent_transfer
,JSON_UNQUOTE(JSON_EXTRACT(inv_agent_people_json, "$[0].name") ) as agent_supervisor_name
,DATE_FORMAT(cdr_date, '%Y-%m-%d') as start_date
,DATE_FORMAT(cdr_calldate, '%H:%i:%s') as start_time
,cdr_call_class as call_class
,cdr_src as call_source
,cdr_dst as call_destiny
,SEC_TO_TIME(cdr_duration_sec) as duration
,cdr_disposition as call_status
,cdr_call_type as call_type
,cdr_recordingfile as record
,DATE_FORMAT(callentry_datetime_entry_queue, '%H:%i:%s') as queue_time
,DATE_FORMAT(callentry_datetime_init, '%H:%i:%s') as connection_time
,DATE_FORMAT(callentry_datetime_end, '%H:%i:%s') as end_time
,IF(callentry_hung_agent = 1, DATE_FORMAT(callentry_datetime_end, '%H:%i:%s'), null) as time_hung_agent
,IF(callentry_hung_caller = 1, DATE_FORMAT(callentry_datetime_end, '%H:%i:%s'), null) as time_hung_caller
,IF(callentry_status = 'abandonada', DATE_FORMAT(callentry_datetime_end, '%H:%i:%s'), null) as time_abandoned

-- ---------------------------------------------------------------
-- TABLES & JOINS

FROM

MainCdr
LEFT OUTER JOIN InvAgent
ON cdr_agent_id = inv_agent_id

LEFT OUTER JOIN InvQueue
ON cdr_queue_id = inv_queue_id

LEFT OUTER JOIN MainCallEntry
ON cdr_uniqueid = callentry_uniqueid


-- ---------------------------------------------------------------
-- CONDITIONS
WHERE 1

-- TIME AND DATE

  AND (
    DATE(cdr_calldate) BETWEEN '2019-01-01' AND '2019-01-01'
    OR
    DATE(cdr_calldate) BETWEEN '2019-01-01' AND '2019-01-01'
  ) 


-- AGENT


-- SUPERVISOR


-- SCHEDULE


-- ROLE


-- CLIENT


-- QUEUE


-- SERVICE


-- CAMPAIGN





LIMIT 500

-- ---------------------------------------------------------------
-- END
