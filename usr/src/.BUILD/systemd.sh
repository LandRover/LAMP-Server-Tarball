#!/bin/bash

apt-get -y install libsystemd-dev meson ninja-build;

# Dependencies that must exist prior to the current build. If not found, will try to install
DEPENDENCIES=(Linux-PAM libcap zstd libgcrypt libgpg-error libidn2);

# build data
VERSION="256.2";
DIST_URL="https://github.com/systemd/systemd/archive/refs/tags/v${VERSION}.tar.gz";
APP_NAME="systemd";

source ./helpers/build_pre/.pre-start.sh;

export CFLAGS="-I${BIN_DIR}/Linux-PAM/include -I${BIN_DIR}/libcap/include -I${BIN_DIR}/zstd/include -I${BIN_DIR}/libgcrypt/include -I${BIN_DIR}/libgpg-error/include -I${BIN_DIR}/libidn2/include";

rm -rf build;
meson setup build;
cd build;
ninja pam_systemd.so || die 0 "[${APP_NAME}] Make install failed";

echo "[INFO] Moving pam_systemd.so to ${BIN_DIR}/Linux-PAM/security/";
mv pam_systemd.so ${BIN_DIR}/Linux-PAM/security/;

echo "Done ${APP_NAME}.";

cd ..;

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
