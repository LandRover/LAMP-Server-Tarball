#!/bin/bash

BUILD="../${PWD##*/}";
VERSION="1.6.14";
APP_NAME="libpng";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

export CPPFLAGS='-I/opt/local/sbin/zlib/include/';

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION} \
--disable-static;

make;
make install;

${BUILD}/helpers/bin/ln.sh ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};