#!/bin/bash

VERSION="2.5.3";
APP_NAME="freetype";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION};

make;
make install;

rm -rf ${OPT}/${APP_NAME};
ln -s ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};