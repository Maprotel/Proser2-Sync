SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root

## STOP PM2
pm2 kill

## TEST
## cp -f temp.txt /var/www/html/
## cp -f pm2-config.txt /var/www/html/

## ENABLE PROSER PORTS
firewall-cmd --zone=public --add-port=3151/tcp --permanent;
firewall-cmd --zone=public --add-port=3152/tcp --permanent;
firewall-cmd --reload

## UNZIP FILE
mkdir -p /var/www/html/proser

unzip -o proser_reports.zip -d /var/www/html/proser
unzip -o assets.zip -d /var/www/html/

## CONFIG FILES
mkdir -p /var/www/html/proser/proser_reports/dist/assets-main

cp -f config/index.html  /var/www/html/
cp -f config/htaccess  /var/www/html/.htaccess
cp -f config/env  /var/www/html/proser/proser_reports/.env
cp -f config/env.js  /var/www/html/proser/proser_reports/assets-main/
cp -f config/hostInfo  /var/www/html/proser/proser_reports/.hostInfo


## Main

cp -f config/env.js  /var/www/html/proser/proser_reports/dist/assets-main/
cp -f config/client-intro.png /var/www/html/assets/img/logos_client/
cp -f config/client-logo.png  /var/www/html/assets/img/logos_client/


## INSTALL NODE MODULES
cd /var/www/html/proser/proser_reports/
npm i
npm audit fix

## RESTART PM2
pm2 kill
pm2 resurrect
pm2 list
