#!/bin/bash
cd /home/judge/src/core/
chmod +x install.sh
./install.sh
#service mysql start
/etc/init.d/judged start
/etc/init.d/php7.1-fpm start
service nginx start

/bin/bash
exit 0
