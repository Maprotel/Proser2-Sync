CREATE OR REPLACE INDEX cdr_uniqueid ON MainCdr(cdr_uniqueid);

CREATE INDEX IF NOT EXISTS callentry_uniqueid ON MainCallEntry(callentry_uniqueid);
CREATE INDEX IF NOT EXISTS cdr_uniqueid ON MainCdr(cdr_uniqueid);
CREATE INDEX IF NOT EXISTS queuelog_uniqueid ON MainQueueLog(queuelog_uniqueid);

CREATE INDEX IF NOT EXISTS callentry_uniqueid ON RealCallEntry(callentry_uniqueid);
CREATE INDEX IF NOT EXISTS cdr_uniqueid ON RealCdr(cdr_uniqueid);
CREATE INDEX IF NOT EXISTS queuelog_uniqueid ON RealQueueLog(queuelog_uniqueid);


CREATE INDEX IF NOT EXISTS queuelog_created ON RealQueueLog(queuelog_created);
CREATE INDEX IF NOT EXISTS queuelog_created ON MainQueueLog(queuelog_created);

ALTER TABLE `MainAudit` CHANGE `audit_operation_json` `audit_operation_json` VARCHAR(250) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT '{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}';

ALTER TABLE `RealAudit` CHANGE `audit_operation_json` `audit_operation_json` VARCHAR(250) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT '{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}';

-- ADD INDEX
ALTER TABLE `MainCallEntry` ADD `__INDEX__` INT NULL AFTER `callentry_time_json`, ADD `cdr_index_supervisor` VARCHAR(100) NULL AFTER `__INDEX__`, ADD `cdr_index_agent` VARCHAR(100) NULL AFTER `cdr_index_supervisor`, ADD `cdr_index_role` VARCHAR(100) NULL AFTER `cdr_index_agent`, ADD `cdr_index_schedule` VARCHAR(100) NULL AFTER `cdr_index_role`, ADD `cdr_index_client` VARCHAR(100) NULL AFTER `cdr_index_schedule`, ADD `cdr_index_queue` VARCHAR(100) NULL AFTER `cdr_index_client`, ADD `cdr_index_service` VARCHAR(100) NULL AFTER `cdr_index_queue`, ADD `cdr_index_campaign` VARCHAR(100) NULL AFTER `cdr_index_service`;

UPDATE `MainCallEntry` SET `cdr_index_supervisor`= JSON_EXTRACT(`callentry_people_json`, '$.supervisor.id');

UPDATE `MainCallEntry` SET `cdr_index_agent`= JSON_EXTRACT(`callentry_people_json`, '$.agent[0].id');