#!/bin/bash

# build data
VERSION="2.1.1";
DIST_URL="https://github.com/influxdata/influxdb/archive/refs/tags/v${VERSION}.tar.gz";
APP_NAME="influxdb2";
USER="${APP_NAME}";
GROUP="${APP_NAME}";
DATA_DIR="/home/${USER}/db_data";

source ./helpers/build_pre/.pre-start.sh;

## Create user for exim
[ -z "$(getent group ${GROUP})" ] && echo "[info] Group not found, creating.." && groupadd -r ${GROUP} --gid=1000;
[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -r -g ${GROUP} --uid=1000 -M -s /bin/false -d /home/${USER} ${USER};

## Create DATADIR
[ ! -d "${DATA_DIR}" ] && echo "[INFO] Datadir for ${APP_NAME} not found, creating..." && mkdir -p ${DATA_DIR} && chown ${USER}:${GROUP} ${DATA_DIR}/.. -R;

## INSTALL
[ -d "${BIN_DIR}/${APP_NAME}-${VERSION}/bin" ] && echo "[INFO] Detected previous install of ${APP_NAME}, Version: ${VERSION}. Removing..." && rm -rf ${BIN_DIR}/${APP_NAME}-${VERSION};
mkdir -p ${BIN_DIR}/${APP_NAME}-${VERSION}/bin;
cp ../${APP_NAME}-${VERSION}/influxd ${BIN_DIR}/${APP_NAME}-${VERSION}/bin/;

echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER} ${DATA_DIR};
