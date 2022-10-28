#!/bin/bash

## libs required
apt-get -y install python3-setuptools 2to3;

# build data
VERSION="1.0.1";
DIST_URL="https://github.com/fail2ban/fail2ban/archive/${VERSION}.tar.gz";
APP_NAME="fail2ban";
USER="${APP_NAME}";

source ./helpers/build_pre/.pre-start.sh;

[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd --system -s /bin/false -d /dev/null --groups adm ${USER}

echo "Trying to setup ${APP_NAME}...";

./fail2ban-2to3;

python3 setup.py install \
--home=${DESTINATION} \
|| die 0 "[${APP_NAME}] Make failed";

echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
