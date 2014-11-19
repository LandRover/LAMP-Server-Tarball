#!/bin/bash

BUILD="../${PWD##*/}";
VERSION="0.72";
APP_NAME="suphp";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

## version 0.7.1 does not support apache 2.4.X

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION} \
#--with-apxs=${OPT}/httpd/bin/apxs \
--with-apache-user=apache \
--with-logfile=${OPT}/httpd/logs/suphp_log \
--with-setid-mode=paranoid \
--sysconfdir=/etc \
--with-apr=${OPT}/apr \
--enable-suphp_USE_USERGROUP=yes;

make;
make install;

${BUILD}/helpers/bin/ln.sh ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};