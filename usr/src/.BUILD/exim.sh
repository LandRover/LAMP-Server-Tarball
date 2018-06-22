#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(pcre db openssl);

apt-get -y install libperl-dev libxaw7-dev libxt-dev;

# build data
VERSION="4.91";
DIST_URL="https://ftp.exim.org/pub/exim/exim4/exim-${VERSION}.tar.gz";
APP_NAME="exim";
USER="exim";

source ./helpers/build_pre/.pre-start.sh;

## Create user for exim
[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d /dev/null ${USER};

## Settings for build
${BUILD}/helpers/bin/ln.sh ${BUILD}/helpers/templates/${APP_NAME}/Makefile /usr/src/${APP_NAME}/Local/Makefile;
${BUILD}/helpers/bin/ln.sh ${BUILD}/helpers/templates/${APP_NAME}/eximon.conf /usr/src/${APP_NAME}/Local/eximon.conf;

make makefile;
make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER};