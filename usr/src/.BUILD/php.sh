#!/bin/bash

BUILD="../${PWD##*/}";
VERSION="5.6.3";
APP_NAME="php";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

/sbin/ldconfig;

./configure \
--prefix=${OPT}/${APP_NAME}-${VERSION} \
--disable-all \
--enable-zip \
--enable-exif \
--enable-hash \
--enable-json \
--enable-fpm \
--enable-opcache \
--enable-pcntl \
--enable-filter \
--enable-mbstring \
--enable-simplexml \
--enable-session \
--enable-xml \
--enable-xmlreader \
--enable-libxml \
--enable-ctype \
--enable-gd-native-ttf \
--enable-inline-optimization \
--with-iconv \
--with-mcrypt=${OPT}/libmcrypt \
--with-gettext \
--with-fpm-user=apache \
--with-fpm-group=apache \
--with-pcre-regex \
--with-config-file-path=/opt/local/etc/php \
--with-config-file-scan-dir=/opt/local/etc/php/php.d \
--with-apxs2=${OPT}/httpd/bin/apxs \
--with-libxml-dir=${OPT}/libxml2 \
--with-zlib-dir=${OPT}/zlib \
--with-openssl=${OPT}/openssl \
--with-mysql=${OPT}/mysql \
--with-mysqli=${OPT}/mysql/bin/mysql_config \
--with-mysql-sock=/var/run/mysql.sock \
--with-curl=${OPT}/curl \
--with-gd \
--with-freetype-dir=${OPT}/freetype \
--with-png-dir=${OPT}/libpng \
--with-jpeg-dir=${OPT}/jpeg;

make;
make install;

${BUILD}/helpers/bin/ln.sh ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};