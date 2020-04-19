#!/bin/bash

# USAGE: place in .bashrc:
#   export PKG_CONFIG_PATH=`/usr/src/.BUILD/helpers/get_pkgconfig_libs.sh`

VARLIST=`find /opt/local/sbin/ -maxdepth 1 -type l -print`

export PKG_CONFIG_PATH=/usr/lib/pkgconfig/

for i in ${VARLIST[@]}; do
	export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$i/lib/pkgconfig/
done

echo $PKG_CONFIG_PATH;