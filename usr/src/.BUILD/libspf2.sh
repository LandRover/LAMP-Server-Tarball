#!/bin/bash

# build data
VERSION="1.2.10";
DIST_URL="https://www.libspf2.org/spf/libspf2-${VERSION}.tar.gz";
APP_NAME="libspf2";

source ./helpers/build_pre/.pre-start.sh;

COMPILE_FROM_SOURCE=true;

[ "$COMPILE_FROM_SOURCE" != true ] && apt-get -y install spf-tools-perl;

## wont comple without - pending pull request fix: https://github.com/shevek/libspf2/pull/5/files
perl -pi -e 's|SPF_debugx\( __FILE__, __LINE__, format, __VA_ARGS__ \)|SPF_debugx\( __FILE__, __LINE__, format, ##__VA_ARGS__ \)|g' ./src/include/spf_log.h
perl -pi -e 's|www.openspf.org|www.open-spf.org|g' ./src/include/spf.h

./configure \
--host=x86_64-linux-gnu \
--prefix=${DESTINATION} \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

echo "Make test ${APP_NAME}...";
make check || die 0 "[${APP_NAME}] Make test failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
