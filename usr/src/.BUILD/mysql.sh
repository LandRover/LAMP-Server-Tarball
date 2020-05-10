#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl curl);

# build data
VERSION="8.0.19";
DIST_URL="https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-${VERSION}.tar.gz";
APP_NAME="mysql";
USER="mysql";
DATA_DIR="db_data";

source ./helpers/build_pre/.pre-start.sh;

##add to startup @ redhat:
##chkconfig --add mysqld

rm -rf CMakeCache.txt;

cmake \
-DCMAKE_INSTALL_PREFIX=${DESTINATION} \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_unicode_ci \
-DMYSQL_DATADIR=/home/${USER}/${DATA_DIR} \
-DMYSQL_UNIX_ADDR=/var/run/${APP_NAME}/mysql.sock \
-DSYSCONFDIR=${ETC_DIR}/${APP_NAME} \
-DMYSQL_USER=${USER} \
-DMYSQL_TCP_PORT=3306 \
-DENABLED_LOCAL_INFILE=1 \
-DFORCE_INSOURCE_BUILD=1 \
-DFEATURE_SET=community \
-DWITH_EMBEDDED_SERVER=OFF \
-DWITH_READLINE=1 \
-DDOWNLOAD_BOOST=1 \
-DWITH_BOOST=.. \
-DWITH_CURL=${BIN_DIR}/curl \
-DWITH_SSL=${BIN_DIR}/openssl \
-DOPENSSL_EXECUTABLE=${BIN_DIR}/openssl/bin/openssl \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER} ${DATA_DIR};
