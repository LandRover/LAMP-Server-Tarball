#!/bin/bash

BUILD="../${PWD##*/}";
VERSION="2.6.8";
APP_NAME="mcrypt";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

export LD_LIBRARY_PATH=${OPT}/libmcrypt/lib:${OPT}/mhash/lib;
export LDFLAGS="-L${OPT}/mhash/lib/ -I${OPT}/mhash/include/";
export CFLAGS="-I${OPT}/mhash/include/";

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION} \
--with-libmcrypt-prefix=${OPT}/libmcrypt;

make;
make install;

${BUILD}/helpers/bin/ln.sh ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};