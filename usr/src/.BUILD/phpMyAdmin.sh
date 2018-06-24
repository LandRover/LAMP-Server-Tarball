#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(httpd php);

# build data
VERSION="4.8.2-english";
DIST_URL="https://files.phpmyadmin.net/phpMyAdmin/4.8.1/phpMyAdmin-${VERSION}.tar.gz";
APP_NAME="phpMyAdmin";
USER="apache";

source ./helpers/build_pre/.pre-start.sh;

[ ! -d "${DESTINATION}" ] && mkdir ${DESTINATION};
cp -RLf ./* ${DESTINATION};

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER};
