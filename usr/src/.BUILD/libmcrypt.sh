#!/bin/bash

BUILD="../${PWD##*/}";
VERSION="2.5.8";
APP_NAME="libmcrypt";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION};

make;
make install;

${BUILD}/helpers/bin/ln.sh ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};