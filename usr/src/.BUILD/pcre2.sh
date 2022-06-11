#!/bin/bash

# build data
VERSION="10.40";
DIST_URL="https://github.com/PhilipHazel/pcre2/archive/refs/tags/pcre2-${VERSION}.tar.gz";
APP_NAME="pcre2";

./helpers/bin/ln.sh /usr/src/${APP_NAME}-${APP_NAME}-${VERSION} /usr/src/${APP_NAME}-${VERSION};

source ./helpers/build_pre/.pre-start.sh;

./autogen.sh;

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
--with-match-limit-recursion=10000000 \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
