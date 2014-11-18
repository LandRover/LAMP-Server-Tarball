#!/bin/bash

cd ../mcrypt;

export LD_LIBRARY_PATH=/opt/local/sbin/libmcrypt/lib:/opt/local/sbin/mhash/lib
export LDFLAGS='-L/opt/local/sbin/mhash/lib/ -I/opt/local/sbin/mhash/include/'
export CFLAGS='-I/opt/local/sbin/mhash/include/'

./configure \
--prefix=/opt/local/sbin/mcrypt-2.6.8 \
--with-libmcrypt-prefix=/opt/local/sbin/libmcrypt;

make;
make install;