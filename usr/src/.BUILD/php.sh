#!/bin/bash

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
--with-mcrypt=/opt/local/sbin/libmcrypt \
--with-gettext \
--with-fpm-user=apache \
--with-fpm-group=apache \
--with-pcre-regex \
--with-config-file-path=/opt/local/etc/php \
--with-config-file-scan-dir=/opt/local/etc/php/php.d \
--with-apxs2=/opt/local/sbin/httpd/bin/apxs \
--with-libxml-dir=/opt/local/sbin/libxml2 \
--with-zlib-dir=/opt/local/sbin/zlib \
--with-openssl=/opt/local/sbin/openssl \
--with-mysql=/opt/local/sbin/mysql \
--with-mysqli=/opt/local/sbin/mysql/bin/mysql_config \
--with-mysql-sock=/var/run/mysql.sock \
--with-curl=/opt/local/sbin/curl \
--with-gd \
--with-freetype-dir=/opt/local/sbin/freetype \
--with-png-dir=/opt/local/sbin/libpng \
--with-jpeg-dir=/opt/local/sbin/jpeg;

make;
make install;

rm -rf ${OPT}/${APP_NAME};
ln -s ${OPT}/${APP_NAME}-${VERSION} ${OPT}/${APP_NAME};