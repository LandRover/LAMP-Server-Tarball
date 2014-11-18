#!/bin/bash

VERSION="1.5.4";
APP_NAME="apr-util";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION} \
--with-apr=/opt/local/sbin/apr;

make;
make install;

rm -rf ${OPT}/${APP_NAME};
ln -s ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};