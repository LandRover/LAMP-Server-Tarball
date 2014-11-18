#!/bin/sh

cd ../jpeg;

./configure \
--prefix=/opt/local/sbin/jpeg-9a \
--enable-shared;

make;
make install;