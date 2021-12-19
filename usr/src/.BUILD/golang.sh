#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl libidn2 nghttp2 zlib);

# build data
VERSION="1.17.5";
DIST_URL="https://storage.googleapis.com/golang/go${VERSION}.linux-amd64.tar.gz";
APP_NAME="go";

source ./helpers/build_pre/.pre-start.sh;

# GO PATHS
GOROOT="${LOCAL_PATH}/go";
GOPATH="~/go";

## Modify global path for this run
PATH=$PATH:${GOPATH}/bin:${GOROOT}/bin


echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
