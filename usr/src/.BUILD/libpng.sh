#!/bin/bash

VERSION="1.6.14";
APP_NAME="libpng";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

export CPPFLAGS='-I/opt/local/sbin/zlib/include/';

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION} \
--disable-static \
--disable-shared;

make;
make install;

rm -rf ${OPT}/${APP_NAME};
ln -s ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};