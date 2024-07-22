#!/bin/bash

# build data
VERSION="8.18.1";
DIST_URL="https://ftp.sendmail.org/sendmail.${VERSION}.tar.gz";
APP_NAME="milter";

source ./helpers/build_pre/.pre-start.sh;

cd libmilter;

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make \
DESTDIR="${DESTINATION}" \
install || die 0 "[${APP_NAME}] Make install failed";

echo "[INFO] path is miss placed inside ./usr, move up";
mv ${DESTINATION}/usr/* ${DESTINATION} && rm -rf ${DESTINATION}/usr;

echo "Done ${APP_NAME}.";

cd ..;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
