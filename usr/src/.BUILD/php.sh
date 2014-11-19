#!/bin/bash

#TODO: change build path to use latest pcre

# build data
BUILD="../${PWD##*/}";
VERSION="5.6.3";
APP_NAME="php";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

cd ../${APP_NAME};

make clean;

/sbin/ldconfig;

./configure \
--prefix=${DESTINATION} \
--disable-all \
--enable-ctype \
--enable-exif \
--enable-filter \
--enable-fpm \
--enable-gd-native-ttf \
--enable-hash \
--enable-inline-optimization \
--enable-json \
--enable-libxml \
--enable-mbstring \
--enable-opcache \
--enable-pcntl \
--enable-session \
--enable-simplexml \
--enable-xml \
--enable-xmlreader \
--enable-zip \
--with-apxs2=${BIN_DIR}/httpd/bin/apxs \
--with-config-file-path=${ETC_DIR}/php \
--with-config-file-scan-dir=${ETC_DIR}/php/php.d \
--with-curl=${BIN_DIR}/curl \
--with-fpm-group=apache \
--with-fpm-user=apache \
--with-freetype-dir=${BIN_DIR}/freetype \
--with-gd \
--with-gettext \
--with-iconv \
--with-jpeg-dir=${BIN_DIR}/jpeg \
--with-libxml-dir=${BIN_DIR}/libxml2 \
--with-mcrypt=${BIN_DIR}/libmcrypt \
--with-mysql-sock=/var/run/mysqld/mysql.sock \
--with-mysql=${BIN_DIR}/mysql \
--with-mysqli=${BIN_DIR}/mysql/bin/mysql_config \
--with-openssl=${BIN_DIR}/openssl \
--with-pcre-regex=${BIN_DIR}/pcre \
--with-png-dir=${BIN_DIR}/libpng \
--with-zlib-dir=${BIN_DIR}/zlib;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};