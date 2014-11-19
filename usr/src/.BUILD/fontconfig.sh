#!/bin/bash

BUILD="../${PWD##*/}";
VERSION="2.11.1";
APP_NAME="fontconfig";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

#export FREETYPE_CFLAGS='-I${OPT}/freetype/include/freetype2';
#export FREETYPE_LIBS='-L${OPT}/freetype/lib';
#export LIBXML2_CFLAGS='-I${OPT}/libxml2/include/libxml2';
#export LIBXML2_LIBS='-L${OPT}/libxml2';

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION} \
--enable-libxml2 \
--with-arch=arm \
FREETYPE_CFLAGS="-I${OPT}/freetype/include/freetype2" \
FREETYPE_LIBS="-L${OPT}/freetype/lib -lfreetype" \
LIBXML2_CFLAGS="-I${OPT}/libxml2/include/libxml2" \
LIBXML2_LIBS="-L${OPT}/libxml2/lib -lxml2 -lm";

make V=1;
make install;

${BUILD}/helpers/bin/ln.sh ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};