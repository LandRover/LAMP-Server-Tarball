#!/bin/bash

VERSION="1.6.14";
APP_NAME="libpng";
OPT="/opt/local/sbin";

cd ../$(APP_NAME);

make clean;

export LDFLAGS='-L/opt/local/sbin/zlib/lib/ -I/opt/local/sbin/zlib/include/'
export CFLAGS='-I/opt/local/sbin/zlib/include/'

./configure \
--prefix=$(OPT)/$(APP_NAME)-$(VERSION) \
--disable-shared;

make;
make install;

rm -rf $(OPT)/$(APP_NAME);
ln -s $(OPT)/$(APP_NAME)-$(VERSION) $(OPT)/$(APP_NAME);