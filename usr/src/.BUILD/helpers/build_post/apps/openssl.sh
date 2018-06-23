#!/bin/bash

CACERT_PATH="http://curl.haxx.se/ca/cacert.pem";

echo "[info] Downloading CACERT from ${CACERT_PATH}";
wget ${CACERT_PATH} -O ${ETC_DIR}/{$APP_NAME}/certs/cacert.pem