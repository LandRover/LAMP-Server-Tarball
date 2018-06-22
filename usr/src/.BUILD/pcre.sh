#!/bin/bash

# build data
VERSION="8.42";
DIST_URL="https://netix.dl.sourceforge.net/project/pcre/pcre/${VERSION}/pcre-${VERSION}.tar.gz";
APP_NAME="pcre";

source ./helpers/build_pre/.pre-start.sh;

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

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};