#!/bin/bash

# build data
VERSION="3.1.2";
DIST_URL="https://netix.dl.sourceforge.net/project/scons/scons/${VERSION}/scons-${VERSION}.tar.gz";
APP_NAME="scons";

source ./helpers/build_pre/.pre-start.sh;

python setup.py install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
