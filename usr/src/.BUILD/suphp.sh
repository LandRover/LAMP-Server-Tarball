#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="0.72";
APP_NAME="suphp";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

cd ../${APP_NAME};

make clean;

## version 0.7.2 does not support apache 2.4.X

./configure \
--prefix=${DESTINATION} \
#--with-apxs=${BIN_DIR}/httpd/bin/apxs \
--with-apache-user=apache \
--with-logfile=${BIN_DIR}/httpd/logs/suphp_log \
--with-setid-mode=paranoid \
--sysconfdir={$ETC_DIR} \
--with-apr=${BIN_DIR}/apr \
--enable-suphp_USE_USERGROUP=yes;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};