#!/bin/sh
VERSION="2.11.1";
APP_NAME="fontconfig";
OPT="/opt/local/sbin";

cd ../$(APP_NAME);

make clean;

#apt-get install pkg-config libxml2 libxml2-dev;

#export FREETYPE_CFLAGS='-I/opt/local/sbin/freetype/include/freetype2';
#export FREETYPE_LIBS='-L/opt/local/sbin/freetype/lib';
#export LIBXML2_CFLAGS='-I/opt/local/sbin/libxml2/include/libxml2';
#export LIBXML2_LIBS='-L/opt/local/sbin/libxml2';

./configure \
--prefix=$(OPT)/$(APP_NAME)-$(VERSION) \
--enable-libxml2 \
--with-arch=arm \
FREETYPE_CFLAGS='-I/opt/local/sbin/freetype/include/freetype2' \
FREETYPE_LIBS='-L/opt/local/sbin/freetype/lib -lfreetype' \
LIBXML2_CFLAGS='-I/opt/local/sbin/libxml2/include/libxml2' \
LIBXML2_LIBS='-L/opt/local/sbin/libxml2/lib -lxml2 -lm';

rm -rf $(OPT)/$(APP_NAME);
ln -s $(OPT)/$(APP_NAME)-$(VERSION) $(OPT)/$(APP_NAME);

make V=1;
make install;