#!/bin/bash

BUILD="../${PWD##*/}";
VERSION="5.6.21";
APP_NAME="mysql";
OPT="/opt/local/sbin";
USER="mysql";

cd ../${APP_NAME};

make clean;

groupadd ${USER};
useradd -d /home/mysql -g ${USER} -s /bin/false ${USER};

#http://zetcode.com/databases/mysqltutorial/installation/
#http://alinux.web.id/2011/08/14/compiling-mysql-5.5.12-with-cmake-on-centos.html

##add to startup @ redhat:
##chkconfig --add mysqld

rm -rf CMakeCache.txt;

cmake \
-DCMAKE_INSTALL_PREFIX=${OPT}/${APP_NAME}-${VERSION} \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DMYSQL_UNIX_ADDR=/var/run/mysql.sock \
-DSYSCONFDIR=/opt/local/etc;

make;
make install;

${BUILD}/helpers/bin/ln.sh ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};

chown -R ${USER}:${USER} ${OPT}/${APP_NAME}
#scripts/mysql_install_db --user=${APP_NAME}