#!/bin/sh

cd ../freetype;

make clean;

./configure \
--prefix=/opt/local/sbin/freetype-2.4.10;

make;
make install;