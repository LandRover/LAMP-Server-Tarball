#!/bin/bash

# build data
VERSION="4.10.2";
DIST_URL="https://github.com/go-acme/lego/releases/download/v${VERSION}/lego_v${VERSION}_linux_amd64.tar.gz";
APP_NAME="lego";

source ./helpers/build_pre/.pre-start.sh;

## INSTALL
[ -d "${BIN_DIR}/${APP_NAME}-${VERSION}/bin" ] && echo "[INFO] Detected previous install of ${APP_NAME}, Version: ${VERSION}. Removing..." && rm -rf ${BIN_DIR}/${APP_NAME}-${VERSION};
mkdir -p ${BIN_DIR}/${APP_NAME}-${VERSION}/bin;
cp ./${APP_NAME}-${VERSION} ${BIN_DIR}/${APP_NAME}-${VERSION}/bin/;

echo "Done ${APP_NAME}.";

# Example usage:
# REGISTER - /opt/local/sbin/lego/bin/lego --accept-tos --email="letsencrypt@domain.com" --domains="domain.com" --domains="www.domain.com" --http.webroot /home/domain/public_html --http run;
# RENEW    - /opt/local/sbin/lego/bin/lego --email="letsencrypt@domain.com" --domains="domain.com" --domains="www.domain.com" --http.webroot /home/domain/public_html --http renew --days 90;
# REVOKE   - /opt/local/sbin/lego/bin/lego --email="letsencrypt@domain.com" --domains="domain.com" --domains="www.domain.com" --http.webroot /home/domain/public_html --http revoke;
#
# crontab renew every month:
# 10 10 10 * * /home/domain/ssl/RENEW.sh > /dev/null 2>&1

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER} ${DATA_DIR};
