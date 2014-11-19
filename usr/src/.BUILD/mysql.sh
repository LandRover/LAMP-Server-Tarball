#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="5.6.21";
APP_NAME="mysql";
USER="mysql";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

cd ../${APP_NAME};

make clean;

groupadd ${USER};
useradd -d /home/{$USER} -g ${USER} -s /bin/false ${USER};

#http://zetcode.com/databases/mysqltutorial/installation/
#http://alinux.web.id/2011/08/14/compiling-mysql-5.5.12-with-cmake-on-centos.html

##add to startup @ redhat:
##chkconfig --add mysqld

rm -rf CMakeCache.txt;

cmake \
-DCMAKE_INSTALL_PREFIX=${DESTINATION} \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DMYSQL_UNIX_ADDR=/var/run/mysqld/mysql.sock \
-DSYSCONFDIR=${ETC_DIR}/${APP_NAME} \
-DWITH_INNOBASE_STORAGE_ENGINE=1;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION} ${USER};