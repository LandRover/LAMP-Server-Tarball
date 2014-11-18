#!/bin/bash

VERSION="7.39.0";
APP_NAME="curl";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION};

make;
make install;

rm -rf $(OPT)/${APP_NAME};
ln -s $(OPT)/${APP_NAME)-${VERSION} ${OPT}/${APP_NAME};