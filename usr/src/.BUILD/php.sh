#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(jpeg libpng freetype libxml2 pcre openssl zlib mysql zip curl);

# build data
VERSION="7.4.5";
DIST_URL="http://cz1.php.net/distributions/php-${VERSION}.tar.gz";
APP_NAME="php";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--with-layout=GNU \
--disable-all \
--enable-ipv6 \
--enable-ctype \
--enable-exif \
--enable-filter \
--enable-dom \
--enable-fpm \
--enable-pdo \
--enable-phar \
--enable-inline-optimization \
--enable-json \
--enable-mysqlnd \
--enable-mbstring \
--enable-opcache \
--enable-pcntl \
--enable-bcmath \
--enable-tokenizer \
--enable-session \
--enable-simplexml \
--enable-gd \
--enable-xml \
--enable-xmlreader \
--with-fpm-group=apache \
--with-fpm-user=apache \
--with-config-file-path=${ETC_DIR}/php \
--with-config-file-scan-dir=${ETC_DIR}/php/php.d \
--with-mysql-sock=/var/run/mysql/mysql.sock \
--with-openssl \
--with-gettext \
--with-iconv \
--with-libxml \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-jpeg \
--with-freetype \
--with-xsl \
--with-zlib;

#--with-zip
#--with-curl

make;
make install;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
