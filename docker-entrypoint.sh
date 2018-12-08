#!/bin/bash
cd /home/judge/src/core/
chmod +x install.sh
./install.sh
service mysql start
/etc/init.d/judged start
php7.2-fpm
service nginx start

/bin/bash
exit 0
