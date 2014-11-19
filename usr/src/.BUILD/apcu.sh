#!/bin/bash

BUILD="../${PWD##*/}";
VERSION="4.0.7";
APP_NAME="apcu";
OPT="/opt/local/sbin";

cd ../${APP_NAME};

make clean;

/opt/local/sbin/php/bin/phpize

./configure \
--enable-apc \
--enable-apc-mmap \
--with-apxs=${OPT}/httpd/bin/apxs \
--with-php-config=${OPT}/bin/php-config

make;
make install;