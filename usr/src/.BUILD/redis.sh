#!/bin/bash

# build data
VERSION="4.0.11";
DIST_URL="http://download.redis.io/releases/redis-${VERSION}.tar.gz";
USER="redis";
APP_NAME="redis";

source ./helpers/build_pre/.pre-start.sh;

[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d /home/${USER}/ ${USER};

make -j y;
make PREFIX=${DESTINATION} install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER};
