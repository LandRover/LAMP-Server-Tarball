#!/bin/bash

[ "$0" = "${BASH_SOURCE}" ] && echo "FILE CAN ONLY BE SOURCED, DIRECT EXECUTION IS NOT ALLOWED!" && exit 0;

# Used as a shared focal point for running generic shared between all components
# file is loaded via SOURCE and must NOT BE executed directly.

echo "[info] [SHARED] Executing post build for ${APP_NAME}";

echo "[info] [SHARED] Creating link ${BIN_DIR}/${APP_NAME}";
../helpers/bin/ln.sh ${BIN_DIR}/${APP_NAME}-${VERSION} ${BIN_DIR}/${APP_NAME};
echo "[info] [SHARED] Post build scripts done for ${APP_NAME}";

echo "[info] Executing ${APP_NAME} post build tasks";