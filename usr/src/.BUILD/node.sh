#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(openssl);

# build data
VERSION="v20.15.1";
DIST_URL="https://nodejs.org/dist/${VERSION}/node-${VERSION}.tar.gz";
APP_NAME="node";

source ./helpers/build_pre/.pre-start.sh;

export LIBRARY_PATH=$LIBRARY_PATH:${BIN_DIR}/openssl/lib64

./configure \
--prefix=${DESTINATION} \
--shared-openssl \
--shared-openssl-libpath=${BIN_DIR}/openssl/lib64 \
--shared-openssl-includes=${BIN_DIR}/openssl/include \
--shared-openssl-libname=crypto,ssl \
--openssl-is-fips \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
