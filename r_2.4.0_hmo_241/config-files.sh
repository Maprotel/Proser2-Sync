SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root


## CONFIG FILES
cp -f config/index.html  /var/www/html/
cp -f config/htaccess  /var/www/html/.htaccess
cp -f config/env  /var/www/html/proser_reports/.env
cp -f config/hostInfo  /var/www/html/proser_reports/.hostInfo
cp -f config/env.js  /var/www/html/proser_reports/dist/init/assets/js

cp -f config/client-intro.png /var/www/html/proser_reports/dist/init/assets/img/logos_client/
cp -f config/client-logo.png  /var/www/html/proser_reports/dist/init/assets/img/logos_client/

