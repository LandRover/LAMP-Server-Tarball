#!/bin/bash

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(openssl libidn2 nghttp2 zlib);

# build data
VERSION="1.24.3";
DIST_URL="https://storage.googleapis.com/golang/go${VERSION}.linux-amd64.tar.gz";
APP_NAME="go";

source ./helpers/build_pre/.pre-start.sh;

# GO PATHS
GOROOT="${BIN_DIR}/go";
GOPATH="~/go";

mv ../${APP_NAME}-${VERSION} ${BIN_DIR}/${APP_NAME}-${VERSION};

addAlias ~/.profile "GOROOT" "export GOROOT=$GOROOT";
addAlias ~/.profile "GOPATH" "export GOPATH=$GOPATH";
addAlias ~/.profile "\$GOPATH" "export PATH=\$PATH:\$GOPATH/bin:\$GOROOT/bin";
addAlias ~/.profile "GO111MODULE" "export GO111MODULE=on";

echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
