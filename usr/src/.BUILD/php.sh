#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(jpeg libpng libwebp libgd freetype libxml2 pcre openssl zlib mysql libzip curl);

# build data
VERSION="8.3.8";
DIST_URL="http://cz1.php.net/distributions/php-${VERSION}.tar.gz";
APP_NAME="php";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--with-layout=GNU \
--disable-all \
--enable-bcmath \
--enable-ctype \
--enable-dom \
--enable-exif \
--enable-fileinfo \
--enable-filter \
--enable-fpm \
--enable-gd \
--enable-ipv6 \
--enable-mbstring \
--enable-mysqlnd \
--enable-opcache \
--enable-pcntl \
--enable-pdo \
--enable-phar \
--enable-session \
--enable-simplexml \
--enable-sockets \
--enable-tokenizer \
--enable-xml \
--enable-xmlreader \
--enable-xmlwriter \
--with-config-file-path=${ETC_DIR}/php \
--with-config-file-scan-dir=${ETC_DIR}/php/php.d \
--with-curl \
--with-fpm-user=apache \
--with-fpm-group=apache \
--with-freetype \
--with-gettext \
--with-iconv \
--with-jpeg \
--with-libxml \
--with-mysql-sock=/var/run/mysql/mysql.sock \
--with-mysqli=mysqlnd \
--with-openssl \
--with-pdo-mysql=mysqlnd \
--with-webp \
--with-xsl \
--with-zlib \
|| die 0 "[${APP_NAME}] Configure failed";

#--with-zip

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
