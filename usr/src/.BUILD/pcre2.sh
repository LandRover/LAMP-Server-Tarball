#!/bin/bash

# build data
VERSION="10.34";
DIST_URL="https://ftp.pcre.org/pub/pcre/pcre2-${VERSION}.tar.gz";
APP_NAME="pcre2";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--enable-utf8 \
--enable-pcre2-8 \
--enable-pcre2-16 \
--enable-pcre2-32 \
--enable-unicode \
--enable-unicode-properties \
--enable-newline-is-lf \
--with-link-size=2 \
--with-posix-malloc-threshold=10 \
--with-match-limit=10000000 \
--with-match-limit-recursion=10000000;

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
