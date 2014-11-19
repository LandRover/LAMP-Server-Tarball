#!/bin/bash

BUILD="../${PWD##*/}";
VERSION="9a";
APP_NAME="jpeg";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION} \
--enable-shared;

make;
make install;

${BUILD}/helpers/bin/ln.sh ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};