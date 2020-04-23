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
--prefix=${DESTINATION};

make;
make check;
make install;
#make maintainer-clean;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
