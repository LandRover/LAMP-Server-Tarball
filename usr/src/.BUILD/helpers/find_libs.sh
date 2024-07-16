#!/bin/bash

# USAGE: place in .bashrc:
#   export PKG_CONFIG_PATH=`/usr/src/.BUILD/helpers/find_libs.sh PKG_CONFIG_PATH /usr/lib/pkgconfig/ /lib/pkgconfig/`

usage() {
    echo "Usage: find_libs.sh <VAR_NAME> <DEFAULT_PATH> <SUB_PATH>"
    echo "  <VAR_NAME>     - Name of the environment var, example: PKG_CONFIG_PATH"
    echo "  <DEFAULT_PATH> - Default path, manually added as main path to search first in os: /usr/lib/pkgconfig/"
    echo "  <SUB_PATH>     - Sub-path to append to each found library, example path: /lib/pkgconfig/"
    return 1
}

if [[ $# -ne 3 ]] || [[ -z "$1" ]] || [[ ! -d "$2" ]] || [[ -z "$3" ]]; then
    echo "Error: Incorrect or invalid parameters.";
    usage;

    exit 1
fi

get_libs() {
    local VAR_NAME=$1;
    local DEFAULT_PATH=$2;
    local SUB_PATH=$3;

    LIBS_LIST=`find /opt/local/sbin/ -maxdepth 1 -type l -print`;

    local EXPORT_PATHS_LIST="${DEFAULT_PATH}";

    for PACKAGE_NAME in ${LIBS_LIST[@]}; do
        EXPORT_PATHS_LIST=${EXPORT_PATHS_LIST}:${PACKAGE_NAME}${SUB_PATH}
    done

    echo ${EXPORT_PATHS_LIST};
}

LIBS_PATH=$(get_libs "${1}" "${2}" "${3}");
export ${1}=${LIBS_PATH}

echo ${LIBS_PATH};
