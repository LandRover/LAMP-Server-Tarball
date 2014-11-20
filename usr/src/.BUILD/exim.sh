#!/bin/bash

#apt-get install libxt-dev libxaw7-dev libxt-dev
apt-get install libperl-dev

# build data
BUILD="../${PWD##*/}";
VERSION="4.84";
APP_NAME="exim";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

cd ../${APP_NAME};

make clean;
make makefile;
make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};