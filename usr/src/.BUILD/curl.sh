#!/bin/bash

BUILD="../${PWD##*/}";
VERSION="7.39.0";
APP_NAME="curl";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION};

make;
make install;

${BUILD}/helpers/bin/ln.sh ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};