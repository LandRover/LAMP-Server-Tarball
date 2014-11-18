#!/bin/sh

cd ../mysql;

#http://zetcode.com/databases/mysqltutorial/installation/
#http://alinux.web.id/2011/08/14/compiling-mysql-5.5.12-with-cmake-on-centos.html

##add to startup @ read hat:
##chkconfig --add mysqld

rm -rf CMakeCache.txt;

cmake -DCMAKE_INSTALL_PREFIX=/opt/local/sbin/mysql-5.5.29;
make;
make install;