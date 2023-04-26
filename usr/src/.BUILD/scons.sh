#!/bin/bash

# build data
VERSION="4.5.2";
DIST_URL="https://iweb.dl.sourceforge.net/project/scons/scons/${VERSION}/SCons-${VERSION}.tar.gz";
APP_NAME="SCons";

source ./helpers/build_pre/.pre-start.sh;

python setup.py install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
