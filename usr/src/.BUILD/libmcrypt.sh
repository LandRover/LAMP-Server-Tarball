#!/bin/bash

cd ../libmcrypt;

./configure \
--prefix=/opt/local/sbin/libmcrypt-2.5.8;

make;
make install;