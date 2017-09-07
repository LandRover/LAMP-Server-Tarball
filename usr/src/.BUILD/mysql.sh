#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="5.6.27";
DIST_URL="https://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-${VERSION}.tar.gz";
APP_NAME="mysql";
USER="mysql";
DATA_DIR="db_data";
RANDOM_PASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w8 | head -n1);

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

##add to startup @ redhat:
##chkconfig --add mysqld

rm -rf CMakeCache.txt;

cmake \
-DCMAKE_INSTALL_PREFIX=${DESTINATION} \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DMYSQL_DATADIR=/home/${USER}/${DATA_DIR} \
-DMYSQL_UNIX_ADDR=/var/run/${APP_NAME}/mysql.sock \
-DSYSCONFDIR=${ETC_DIR}/${APP_NAME} \
-DWITH_INNOBASE_STORAGE_ENGINE=1;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION} ${USER} ${DATA_DIR} ${RANDOM_PASSWORD};