#!/bin/bash
VERSION="7.39.0";
BUILD_NAME="curl";
OPT="/opt/local/sbin";

cd ../$(BUILD_NAME);

./configure \
--prefix=$(OPT)/$(BUILD_NAME)-$(VERSION);

rm -rf $(OPT)/$(BUILD_NAME);
ln -s $(OPT)/$(BUILD_NAME)-$(VERSION) $(OPT)/$(BUILD_NAME);

make;
make install;