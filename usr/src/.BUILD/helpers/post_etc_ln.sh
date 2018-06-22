#!/bin/bash

# Validation object, shared currently for creating profile.d, ld.conf.d & tmpfiles.d.
# External params must be provided:
#   SRC_DIR, SERVICE, FILE_NAME
#   more info about the params @ usage

SRC_DIR="$1";
SERVICE="$2";
FILE_NAME="$3";
DST_DIR="/etc";
CPWD="`dirname ${BASH_SOURCE}`";

function usage {
    if [ ! -z "$1" ]; then
        echo $1;
        echo "";
    fi

    echo "USAGE: $0 <src_dir> <service> <file_name>";
    echo "";
    echo "<src_dir> - usually for my setup would be /opt/local/etc";
    echo "<service> - depends on what's being created [profile.d || ld.so.conf.d || tmpfiles.d]";
    echo "<file_name> - file to be linked";
    echo "";

    exit 0;
}

[[ -z "${SRC_DIR}" || -z "${SERVICE}" || -z "${FILE_NAME}" ]] && usage;
[ ! -d "${SRC_DIR}/${SERVICE}" ] && usage "[error] [ETC_LN] ${SRC_DIR}/${SERVICE} service dir, not found.";
[ ! -e "${SRC_DIR}/${SERVICE}/${FILE_NAME}" ] && usage "[error] [ETC_LN] ${SRC_DIR}/${SERVICE}/${FILE_NAME} path, not found.";

${CPWD}/bin/ln.sh ${SRC_DIR}/${SERVICE}/${FILE_NAME} ${DST_DIR}/${SERVICE}/${FILE_NAME};