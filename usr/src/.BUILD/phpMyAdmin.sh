#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="4.2.11-english";
APP_NAME="phpMyAdmin";
USER="apache";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

cp -RLf ../${APP_NAME}/* ${DESTINATION};

cd ../${APP_NAME};
[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION} ${USER};
