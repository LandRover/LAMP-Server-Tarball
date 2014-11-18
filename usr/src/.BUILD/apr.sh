#!/bin/bash

VERSION="1.5.1";
APP_NAME="apr";
OPT="/opt/local/sbin";

cd ../$(APP_NAME);

make clean;

./configure \
--prefix=$(OPT)/$(APP_NAME)-$(VERSION);

make;
make install;

rm -rf $(OPT)/$(APP_NAME);
ln -s $(OPT)/$(APP_NAME)-$(VERSION) $(OPT)/$(APP_NAME);