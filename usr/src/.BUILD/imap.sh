#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="2007f";
APP_NAME="imap";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

make lr5 EXTRACFLAGS=-fPIC;
mkdir lib;
mkdir include;

cp c-client/*.c lib/;
cp c-client/*.h include/;
cp c-client/c-client.a lib/libc-client.a;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};