#!/bin/bash

apt-get -y install libperl-dev libxaw7-dev libxt-dev;

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
[ ! id -u $USER > /dev/null 2>&1 ] && echo "[info] User ${USER} not found, creating.." && groupadd ${USER} && useradd -M -s /bin/false -d /dev/null;

source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

## Settings for build
${BUILD}/helpers/bin/ln.sh ${PWD}/templates/${APP_NAME}/Makefile ../${APP_NAME}/Local/Makefile;
${BUILD}/helpers/bin/ln.sh ${PWD}/templates/${APP_NAME}/eximon.conf ../${APP_NAME}/Local/eximon.conf;

make makefile;
make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION} ${USER};