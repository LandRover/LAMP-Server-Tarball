#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(python);

# build data
VERSION="4.11.1";
DIST_URL="https://github.com/SCons/scons/archive/refs/tags/${VERSION}.tar.gz";
APP_NAME="SCons";

source ./helpers/build_pre/.pre-start.sh;

python setup.py install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
