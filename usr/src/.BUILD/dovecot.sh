#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl);

# build data
VERSION="2.3.10";
DIST_URL="https://dovecot.org/releases/2.3/dovecot-${VERSION}.tar.gz";
APP_NAME="dovecot";

source ./helpers/build_pre/.pre-start.sh;

export CPPFLAGS="-I${BIN_DIR}/openssl/include";
export LDFLAGS="-L${BIN_DIR}/openssl/lib";

./configure \
--prefix=${DESTINATION}\
--sysconfdir=${ETC_DIR}/${APP_NAME};

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER};