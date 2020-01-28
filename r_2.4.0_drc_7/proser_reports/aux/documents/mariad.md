mysqladmin flush-hosts -u root -p


service mysql stop
service mysql start

service mariadb stop
service mariadb start

# service mysql start
or
# /etc/init.d/mysql start


# service mariadb start
or
# /etc/init.d/mariadb start

mysql -u root -p proser_drc_dos_caminos < MainCdr.sql

CREATE OR REPLACE INDEX cdr_uniqueid ON MainCdr(cdr_uniqueid);

CREATE INDEX IF NOT EXISTS callentry_uniqueid ON MainCallEntry(callentry_uniqueid);
CREATE INDEX IF NOT EXISTS cdr_uniqueid ON MainCdr(cdr_uniqueid);
CREATE INDEX IF NOT EXISTS queuelog_uniqueid ON MainQueueLog(queuelog_uniqueid);

CREATE INDEX IF NOT EXISTS callentry_uniqueid ON RealCallEntry(callentry_uniqueid);
CREATE INDEX IF NOT EXISTS cdr_uniqueid ON RealCdr(cdr_uniqueid);
CREATE INDEX IF NOT EXISTS queuelog_uniqueid ON RealQueueLog(queuelog_uniqueid);


CREATE USER 'maprotel'@'localhost' IDENTIFIED BY '***';GRANT ALL PRIVILEGES ON *.* TO 'maprotel'@'localhost' IDENTIFIED BY '***' REQUIRE NONE WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;