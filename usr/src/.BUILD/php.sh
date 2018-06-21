#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(jpeg libpng freetype libxml2 libmcrypt pcre openssl zlib mysql);

# build data
BUILD="../${PWD##*/}";
VERSION="7.2.6";
DIST_URL="http://cz1.php.net/distributions/php-${VERSION}.tar.gz";
APP_NAME="php";

# destination build info
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

source ./helpers/.dependency_install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/.pre_build_unpack.sh; ##unpack tar and enters the app dir

/sbin/ldconfig;

export LIBPNG_LIBS="-L${BIN_DIR}/freetype/lib";
export LIBPNG_CFLAGS="-I${BIN_DIR}/freetype/include/freetype2";

#--with-apxs2=${BIN_DIR}/httpd/bin/apxs \  ## if cgi/fpm is used - NOT NEEDED!
#--enable-bcmath \
./configure \
--prefix=${DESTINATION} \
--disable-all \
--enable-ctype \
--enable-exif \
--enable-filter \
--enable-fpm \
--enable-hash \
--enable-pdo \
--enable-phar \
--enable-inline-optimization \
--enable-json \
--enable-libxml \
--enable-mysqlnd \
--enable-mbstring \
--enable-opcache \
--enable-pcntl \
--enable-tokenizer \
--enable-session \
--enable-simplexml \
--enable-xml \
--enable-xmlreader \
--enable-zip \
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
--with-mysql=mysqlnd \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-mysql-sock=/var/run/mysql/mysql.sock \
--with-openssl=${BIN_DIR}/openssl \
--with-pcre-regex=${BIN_DIR}/pcre \
--with-png-dir=${BIN_DIR}/libpng \
--with-zlib-dir=${BIN_DIR}/zlib;

make;
make install;

[ -a "${BUILD}/post_build/$0" ] && cd ${BUILD}/post_build; $0 ${BIN_DIR} ${APP_NAME} ${VERSION};
