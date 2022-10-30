#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(python);

# build data
VERSION="2022.10";
DIST_URL="https://repo.anaconda.com/archive/Anaconda3-${VERSION}-Linux-x86_64.sh";
APP_NAME="Anaconda3";

source ./helpers/build_pre/.pre-start.sh;

bash ./${APP_NAME}-${VERSION}.tgz

echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
