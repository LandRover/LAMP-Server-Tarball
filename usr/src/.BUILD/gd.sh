#!/bin/sh

cd ../gd;

make clean;

## http://www.linuxforums.org/forum/programming-scripting/47173-make-error-giving-gd-2-0-33-a.html
## modify gd_png.c and replace 'png.h' to: '/opt/local/sbin/libpng/include/png.h'

./configure \
--prefix=/opt/local/sbin/gd-2.0.35 \
--with-jpeg=/opt/local/sbin/jpeg-8d \
--with-png=/opt/local/sbin/libpng \
--with-freetype=/opt/local/sbin/freetype \
--with-fontconfig=/opt/local/sbin/fontconfig;

make;
make install;