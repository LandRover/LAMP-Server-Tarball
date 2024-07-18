#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(cmake openssl curl);

apt-get -y install patchelf;

# build data
VERSION="8.4.1";
DIST_URL="https://cdn.mysql.com//Downloads/MySQL-8.4/mysql-${VERSION}.tar.gz";
APP_NAME="mysql";
USER="mysql";
DATA_DIR="db_data";

source ./helpers/build_pre/.pre-start.sh;

rm -rf CMakeCache.txt build; # Previous build cleanup
mkdir build && cd build; # Builds here

cmake .. \
-DCMAKE_INSTALL_PREFIX=${DESTINATION} \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_unicode_ci \
-DMYSQL_DATADIR=/home/${USER}/${DATA_DIR} \
-DMYSQL_UNIX_ADDR=/var/run/${APP_NAME}/mysql.sock \
-DSYSCONFDIR=${ETC_DIR}/${APP_NAME} \
-DMYSQL_TCP_PORT=3306 \
-DENABLED_LOCAL_INFILE=1 \
-DWITH_CURL=${BIN_DIR}/curl \
-DWITH_SSL=${BIN_DIR}/openssl \
-DWITH_ZLIB="bundled" \
-DOPENSSL_EXECUTABLE=${BIN_DIR}/openssl/bin/openssl \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ..; ## Since we built in ./build, it is required to step up to continue.

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER} ${DATA_DIR};
