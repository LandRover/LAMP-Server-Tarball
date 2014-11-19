#!/bin/bash

BUILD="../${PWD##*/}";
VERSION="1.5.4";
APP_NAME="apr-util";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION} \
--with-apr=/opt/local/sbin/apr;

make;
make install;

${BUILD}/helpers/bin/ln.sh ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};