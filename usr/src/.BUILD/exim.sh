#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(pcre db openssl);

apt-get -y install libperl-dev libxaw7-dev libxt-dev;

# build data
BUILD="../${PWD##*/}";
VERSION="4.85";
APP_NAME="exim";
USER="exim";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

## Create user for exim
[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d /dev/null ${USER};

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

## Settings for build
${BUILD}/helpers/bin/ln.sh /usr/src/.BUILD/templates/${APP_NAME}/Makefile /usr/src/${APP_NAME}/Local/Makefile;
${BUILD}/helpers/bin/ln.sh /usr/src/.BUILD/templates/${APP_NAME}/eximon.conf /usr/src/${APP_NAME}/Local/eximon.conf;

make makefile;
make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION} ${USER};