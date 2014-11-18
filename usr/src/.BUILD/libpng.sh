#!/bin/sh

cd ../libpng;

make clean;

export LDFLAGS='-L/opt/local/sbin/zlib/lib/ -I/opt/local/sbin/zlib/include/'
export CFLAGS='-I/opt/local/sbin/zlib/include/'

./configure --prefix=/opt/local/sbin/libpng-1.5.4 \
--disable-shared;

make;
make install;