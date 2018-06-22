#!/bin/bash

# build data
VERSION="3.0.3";
DIST_URL="https://security.appspot.com/downloads/vsftpd-${VERSION}.tar.gz";
APP_NAME="vsftpd";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION};

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};