#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl);

# build data
VERSION="2007f";
DIST_URL="https://www.mirrorservice.org/sites/ftp.cac.washington.edu/imap/imap-${VERSION}.tar.gz";
APP_NAME="imap";

source ./helpers/build_pre/.pre-start.sh;

#SSLTYPE=nopwd SPECIALS="SSLINCLUDE=${BIN_DIR}/openssl/include SSLLIB=${BIN_DIR}/openssl/lib SSLCERTS=${ETC_DIR}/openssl/certs SSLKEY=${ETC_DIR}/openssl/private";
#make slx SSLTYPE=unix.nopwd EXTRACFLAGS=-fPIC;
make slx SSLTYPE=unix.nopwd EXTRACFLAGS=-fPIC SPECIALS="SSLINCLUDE=${BIN_DIR}/openssl/include SSLLIB=${BIN_DIR}/openssl/lib SSLCERTS=${ETC_DIR}/openssl/certs SSLKEY=${ETC_DIR}/openssl/private";
mkdir lib;
mkdir include;

cp c-client/*.c lib/;
cp c-client/*.h include/;
cp c-client/c-client.a lib/libc-client.a;

mkdir -p ${DESTINATION}/lib;
mkdir -p ${DESTINATION}/include/c-client;
cp -rf lib/*libc-client* ${DESTINATION}/lib;
cp -rf include/* ${DESTINATION}/include/c-client;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
