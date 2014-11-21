#!/bin/bash

apt-get install libperl-dev libxaw7-dev libxt-dev;

# build data
BUILD="../${PWD##*/}";
VERSION="4.84";
APP_NAME="exim";
USER="exim";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

## Create user for exim
groupadd ${USER};
useradd -d /dev/null -g ${USER} -s /bin/false ${USER};

## Settings for build
${BUILD}/helpers/bin/ln.sh ${PWD}/custom/${APP_NAME}/Makefile ../${APP_NAME}/Local/Makefile;
${BUILD}/helpers/bin/ln.sh ${PWD}/custom/${APP_NAME}/eximon.conf ../${APP_NAME}/Local/eximon.conf;

cd ../${APP_NAME};

make clean;
make makefile;
make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION} ${USER};