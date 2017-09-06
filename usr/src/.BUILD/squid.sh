#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl);

# build data
BUILD="../${PWD##*/}";
VERSION="3.5.27";
APP_NAME="squid";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";
USER="${APP_NAME}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

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

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION} ${USER};