#!/bin/bash

# build data
VERSION="1.94.5";
DIST_URL="http://old.greatcircle.com/majordomo/${VERSION}/majordomo-${VERSION}.tar.gz";
APP_NAME="majordomo";
USER="${APP_NAME}";

source ./helpers/build_pre/.pre-start.sh;

## Create user for exim
[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d /dev/null ${USER};

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER};