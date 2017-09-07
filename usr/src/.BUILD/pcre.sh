#!/bin/bash

# build data
BUILD="../${PWD##*/}";
VERSION="8.41";
DIST_URL="https://netix.dl.sourceforge.net/project/pcre/pcre/${VERSION}/pcre-${VERSION}.tar.gz";
APP_NAME="pcre";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

./configure \
--enable-utf8 \
--enable-unicode-properties \
--enable-newline-is-lf \
--with-link-size=2 \
--with-posix-malloc-threshold=10 \
--with-match-limit=10000000 \
--with-match-limit-recursion=10000000 \
--prefix=${DESTINATION};

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};