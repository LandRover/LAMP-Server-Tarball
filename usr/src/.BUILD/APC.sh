#!/bin/bash

VERSION="3.1.13";
APP_NAME="APC";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

/opt/local/sbin/php/bin/phpize

./configure \
--enable-apc \
--enable-apc-mmap \
--with-apxs=/opt/local/sbin/httpd/bin/apxs \
--with-php-config=/opt/local/sbin/php/bin/php-config

make;
make install;