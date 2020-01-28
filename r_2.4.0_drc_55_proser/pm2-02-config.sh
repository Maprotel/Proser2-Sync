SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root

## PM2 CONFIG
pm2 kill
pm2 unstartup

pm2 startup

cd /var/www/html/proser/proser_reports
pm2 kill
# SERVERS
pm2 start --name REPORTS-SERVER ./src/server/server.js --interpreter ./node_modules/.bin/babel-node
# pm2 start --name SERVER-SYSTEM ./src/server/server.js --interpreter ./node_modules/.bin/babel-node

# SYNC
pm2 start --name LOAD-DAY ./src/sync/etl/load/load_day.js --interpreter ./node_modules/.bin/babel-node
#pm2 start --name SYNC-INVENTORY ./src/sync/etl/load/load_inventory.js --interpreter ./node_modules/.bin/babel-node
#pm2 start --name SYNC-HCA ./src/sync/etl/load/load_hca.js --interpreter ./node_modules/.bin/babel-node
#pm2 start --name SYNC-REAL ./src/sync/etl/load/load_real.js --interpreter ./node_modules/.bin/babel-node


pm2 save
