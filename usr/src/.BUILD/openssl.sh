#!/bin/bash

apt-get -y install xutils-dev;

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(zlib);

#http://curl.haxx.se/ca/cacert.pem --> /opt/local/etc/openssl/certs/cacert.pem

# build data
VERSION="1.1.0h";
DIST_URL="https://www.openssl.org/source/openssl-${VERSION}.tar.gz";
APP_NAME="openssl";

source ./helpers/build_pre/.pre-start.sh;

./config \
--prefix=${DESTINATION} \
--openssldir=${ETC_DIR}/${APP_NAME} \
--with-zlib-lib=${BIN_DIR}/zlib/lib \
--with-zlib-include=${BIN_DIR}/zlib/include \
no-ssl2 \
zlib \
no-shared;

make depend;
make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
