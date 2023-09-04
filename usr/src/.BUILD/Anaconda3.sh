#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(python);

# build data
VERSION="2023.07-2";
DIST_URL="https://repo.anaconda.com/archive/Anaconda3-${VERSION}-Linux-x86_64.sh";
APP_NAME="Anaconda3";

source ./helpers/build_pre/.pre-start.sh;

# start installer
bash ./${APP_NAME}-${VERSION}.tgz

# Python version
python -v

# update Anaconda
conda update --all --yes

echo "Done ${APP_NAME}.";

# start:
jupyter notebook

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
