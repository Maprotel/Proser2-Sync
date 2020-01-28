https://www.linode.com/docs/tools-reference/tools/schedule-tasks-with-cron/
https://www.cyberciti.biz/faq/linux-reboot-command/
https://unix.stackexchange.com/questions/42715/how-can-i-make-cron-run-a-job-right-now-for-testing-debugging-without-changing
https://alvinalexander.com/linux/unix-linux-crontab-every-minute-hour-day-syntax


Running job at startup (boot time)
You need to use special string called @reboot. It will run once, at startup after Linux reboot command. The syntax is as follows:

@reboot  /path/to/job
@reboot  /path/to/shell.script
@reboot  /path/to/command arg1 arg2
This is an easy way to give your users the ability to run a shell script or command at boot time without root access. First, run crontab command:
$ crontab -e

OR
# crontab -e -u UserName
# crontab -e -u vivek

Run a script called /home/vivek/bin/installnetkit.sh
@reboot /home/vivek/bin/installnetkit.sh

It i a super-simple way to run scripts on boot using cron jobs.

How to run a cron job automatically after server reboot
Say your script needs to be run only after 5 minutes. For example: reboot + 5mintues. The syntax is as follows:
@reboot sleep 300 && /home/wwwjobs/clean-static-cache.sh

The sleep command to add delay for a specified amount of time. In this example, 600 seconds and after that time clean-static-cache.sh gets executed at boot time.

Start crond automatically at boot time
You also need to enable crond service via sys v / BSD init style system. Under RHEL / CentOS / Fedora, you need to use chkconfig (ntsysv) command to enable crond on boot:
# chkconfig crond on
## Commands to start/stop/restart crond for Linux Execute Cron Job ###
# service crond restart
# service crond start
# service crond stop

Under Debian / Ubuntu Linux use update-rc.d as follows to turn on service on boot:
# update-rc.d cron defaults

If you are using modern distro with systemd, try the following systemctl command
# systemctl enable crond.service
### this to start/stop/restart crond on systemd enabled distro such centos 7.x/debian/ubutnu/arch ###
# systemctl start crond.service
# systemctl stop crond.service
# systemctl restart crond.service
# systemctl status crond.service

For Debian/Ubuntu Linux with systemd, try:
$ sudo systemctl enable cron.service
$ sudo systemctl start cron.service
$ sudo systemctl stop cron.service
$ sudo systemctl restart cron.service
$ sudo systemctl status cron.service

Save and close the file. For further information read out tutorial on cron jobs.

Conclusion
This page showed how to run and execute cron job after system rebooted. For more info see this page here.