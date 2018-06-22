#!/bin/bash

[ "$0" = "${BASH_SOURCE}" ] && echo "FILE CAN ONLY BE SOURCED, DIRECT EXECUTION IS NOT ALLOWED!" && exit 0;

# Validation object, shared between all components. Also provides 3 commonly used vars: BIN_DIR, APP_NAME and VERSION
# file is loaded via SOURCE and must NOT BE executed directly.

function usage {
    if [ ! -z "$2" ]; then
        echo $2;
        echo "";
    fi

    echo "USAGE: $1 <bin_dir> <etc_dir> <app_name> <version> [param1] [param2] [param3]";
    echo "";
    echo "<bin_dir> - Dest build path for apps";
    echo "<etc_dir> - etc build path for apps";
    echo "<app_name> - app name";
    echo "<version> - version being built";
    echo "[param1] - optional param";
    echo "[param2] - optional param";
    echo "[param3] - optional param";

    exit 0;
}

[[ -z "${BIN_DIR}" || -z "${APP_NAME}" || -z "${VERSION}" ]] && usage;
[ ! -d "${BIN_DIR}/${APP_NAME}-${VERSION}" ] && usage "[error] [SHARED] ${BIN_DIR}/${APP_NAME}-${VERSION} dir, not found. Build could have failed.";