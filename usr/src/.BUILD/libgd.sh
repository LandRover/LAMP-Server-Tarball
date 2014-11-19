#!/bin/bash

BUILD="../${PWD##*/}";
VERSION="2.1.0";
APP_NAME="libgd";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION} \
--with-jpeg=/opt/local/sbin/jpeg \
--with-png=/opt/local/sbin/libpng \
--with-freetype=/opt/local/sbin/freetype \
--with-fontconfig=/opt/local/sbin/fontconfig;

make;
make install;

${BUILD}/helpers/bin/ln.sh ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};