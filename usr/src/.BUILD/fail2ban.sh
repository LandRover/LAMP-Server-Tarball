#!/bin/bash

# build data
VERSION="0.9.4";
DIST_URL="https://github.com/fail2ban/fail2ban/archive/${VERSION}.tar.gz";
APP_NAME="fail2ban";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION};

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
