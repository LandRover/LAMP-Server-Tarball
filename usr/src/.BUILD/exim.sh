#!/bin/bash

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
make -C ${ETC_DIR}/${APP_NAME};
make DESTDIR=${DESTINATION} install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};