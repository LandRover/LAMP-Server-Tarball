#!/bin/bash

source ./.post-global-vars.sh;
source ./.post-validate-input.sh;

echo "[info] [SHARED] Creating link ${BIN_DIR}/${APP_NAME}";
../bin/ln.sh ${APP_FULL_DIR} ${BIN_DIR}/${APP_NAME};
echo "[info] [SHARED] Post build scripts done for ${APP_NAME}";

echo "[info] Executing ${APP_NAME} post build tasks";
if [ -f "./apps/${APP_FILE}" ]; then
    echo "[info] Found post script, ${APP_FILE}, executing"
    source ./apps/${APP_FILE};
fi

cd ${POST_DIR};
source ./.post-etc-links.sh;