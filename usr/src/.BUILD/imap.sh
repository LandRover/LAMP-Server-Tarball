#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl);

# build data
BUILD="../${PWD##*/}";
VERSION="2007f";
APP_NAME="imap";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

#SSLTYPE=nopwd SPECIALS="SSLINCLUDE=${BIN_DIR}/openssl/include SSLLIB=${BIN_DIR}/openssl/lib SSLCERTS=${ETC_DIR}/openssl/certs SSLKEY=${ETC_DIR}/openssl/private";
make slx SSLTYPE=unix EXTRACFLAGS=-fPIC;
mkdir lib;
mkdir include;

cp c-client/*.c lib/;
cp c-client/*.h include/;
cp c-client/c-client.a lib/libc-client.a;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};