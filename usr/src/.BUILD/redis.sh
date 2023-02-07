#!/bin/bash

# build data
VERSION="7.0.8";
DIST_URL="http://download.redis.io/releases/redis-${VERSION}.tar.gz";
APP_NAME="redis";
USER="${APP_NAME}";

source ./helpers/build_pre/.pre-start.sh;

[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d /home/${USER}/ ${USER};

echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make PREFIX=${DESTINATION} install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER};
