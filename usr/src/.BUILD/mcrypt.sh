#!/bin/bash

VERSION="2.6.8";
APP_NAME="mcrypt";
OPT="/opt/local/sbin";

cd ../${APP_NAME);

make clean;

export LD_LIBRARY_PATH=/opt/local/sbin/libmcrypt/lib:/opt/local/sbin/mhash/lib
export LDFLAGS='-L/opt/local/sbin/mhash/lib/ -I/opt/local/sbin/mhash/include/'
export CFLAGS='-I/opt/local/sbin/mhash/include/'

./configure \
--prefix=${OPT)/${APP_NAME)-${VERSION) \
--with-libmcrypt-prefix=/opt/local/sbin/libmcrypt;

make;
make install;

rm -rf ${OPT)/${APP_NAME);
ln -s ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};