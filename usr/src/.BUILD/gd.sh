#!/bin/bash

VERSION="2.0.35";
APP_NAME="freetype";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

## http://www.linuxforums.org/forum/programming-scripting/47173-make-error-giving-gd-2-0-33-a.html
## modify gd_png.c and replace 'png.h' to: '/opt/local/sbin/libpng/include/png.h'

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION} \
--with-jpeg=/opt/local/sbin/jpeg \
--with-png=/opt/local/sbin/libpng \
--with-freetype=/opt/local/sbin/freetype \
--with-fontconfig=/opt/local/sbin/fontconfig;

make;
make install;

rm -rf ${OPT}/${APP_NAME};
ln -s ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};