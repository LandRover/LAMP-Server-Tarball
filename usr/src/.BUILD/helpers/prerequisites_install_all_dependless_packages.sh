#!/bin/bash

CPWD="`dirname ${BASH_SOURCE}`";
INSTALL_SCRIPTS_DIR=`realpath ${CPWD}/../`;
BUILD_PATH="/usr/src/.BUILD";
DST_PATH="/opt/local/sbin";

# Function to find and categorize files
find_install_scripts_with_dependencies() {
    local SEARCH_DIR="${1}"
    local SCRIPTS_LIST=()

    while IFS= read -r -d '' INSTALL_SCRIPT_NAME; do
        if ! grep -q "DEPENDENCIES" "${INSTALL_SCRIPT_NAME}"; then
            SCRIPTS_LIST+=("$INSTALL_SCRIPT_NAME")
        fi
    done < <(find ${SEARCH_DIR} -maxdepth 1 -type f -name "*.sh" -print0)

    echo "${SCRIPTS_LIST[@]}"
}

SCRIPTS_LIST=($(find_install_scripts_with_dependencies "$INSTALL_SCRIPTS_DIR"))
TOTAL_SCRIPTS=${#SCRIPTS_LIST[@]}
COMPLETED_COUNT=0

for SCRIPT_NAME in "${SCRIPTS_LIST[@]}"; do
    PACKAGE_NAME=$(basename "${SCRIPT_NAME}" .sh)

    if [ ! -d "${DST_PATH}/${PACKAGE_NAME}" ]; then
        echo "[INFO] Installing package: '${PACKAGE_NAME}'";

        cd ${BUILD_PATH} && bash ${SCRIPT_NAME};

        PROGRESS=$((COMPLETED_COUNT * 100 / TOTAL_SCRIPTS));

        echo "[INFO] [${PROGRESS}%] Installed ${PACKAGE_NAME} successfully.";
    else
        echo "[INFO] Skipping '${PACKAGE_NAME}' as it already installed."
    fi

    ((COMPLETED_COUNT++))

done
