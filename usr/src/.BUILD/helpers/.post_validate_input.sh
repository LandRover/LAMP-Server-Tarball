# Validation object, shared between all components. Also provides 3 commonly used vars: BIN_DIR, APP_NAME and VERSION
# file is loaded via SOURCE and must NOT BE executed directly.

BIN_DIR="$1";
APP_NAME="$2";
VERSION="$3";

function usage {
    if [ ! -z "$1" ]; then
        echo $1;
        echo "";
    fi

    echo "USAGE: $0 <bin_dir> <app_name> <version>";
    echo "";
    echo "<bin_dir> - Dest build path for apps";
    echo "<app_name> - app name";
    echo "<version> - version being built";
    echo "";

    exit 0;
}

[[ -z "${BIN_DIR}" || -z "${APP_NAME}" || -z "${VERSION}" ]] && usage;
[ ! -d "${BIN_DIR}/${APP_NAME}-${VERSION}" ] && usage "[error] [SHARED] ${BIN_DIR}/${APP_NAME}-${VERSION} dir, not found. Build could have failed.";