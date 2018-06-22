#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl);

# build data
VERSION="3.5.27";
DIST_URL="https://launchpad.net/squid/3.5/${VERSION}/+download/squid-${VERSION}.tar.gz";
APP_NAME="squid";
USER="${APP_NAME}";

source ./helpers/build_pre/.pre-start.sh;

## Create user for squid
[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d /dev/null ${USER};

./configure \
--prefix=${DESTINATION} \
--sysconfdir=${ETC_DIR}/${APP_NAME} \
--with-openssl=${BIN_DIR}/openssl \
--with-default-user=${USER} \
--with-swapdir=/dev/null \
--with-pidfile=/var/run/${APP_NAME}.pid \
--with-logdir=/var/log/${APP_NAME};

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER};