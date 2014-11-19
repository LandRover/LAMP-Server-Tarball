#!/bin/bash

BUILD="../${PWD##*/}";
VERSION="1.5.1";
APP_NAME="apr";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION};

make;
make install;

${BUILD}/helpers/bin/ln.sh ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};