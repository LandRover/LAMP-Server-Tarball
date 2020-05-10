#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl libecap);

# build data
VERSION="4.11";
DIST_URL="http://www.squid-cache.org/Versions/v4/squid-${VERSION}.tar.gz";
APP_NAME="squid";
USER="${APP_NAME}";

source ./helpers/build_pre/.pre-start.sh;

## Create user for squid
[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d /dev/null ${USER};

./configure \
--prefix=${DESTINATION} \
--sysconfdir=${ETC_DIR}/${APP_NAME} \
--disable-maintainer-mode \
--disable-dependency-tracking \
--disable-silent-rules \
--disable-arch-native \
--disable-translation \
--enable-build-info="Custom Debian" \
--enable-inline \
--enable-async-io=8 \
--enable-storeio="ufs,aufs,diskd,rock" \
--enable-removal-policies="lru,heap" \
--enable-delay-pools \
--enable-cache-digests \
--enable-icap-client \
--enable-linux-netfilter \
--enable-follow-x-forwarded-for \
--enable-auth-basic="DB,fake,NCSA" \
--enable-auth-digest=file \
--enable-auth-negotiate="wrapper" \
--enable-auth-ntlm=fake \
--enable-external-acl-helpers="file_userip" \
--enable-security-cert-validators=fake \
--enable-storeid-rewrite-helpers=file \
--enable-url-rewrite-helpers=fake \
--enable-eui \
--enable-esi \
--enable-icmp \
--enable-zph-qos \
--enable-ecap \
--with-large-files \
--with-filedescriptors=65536 \
--with-openssl=${BIN_DIR}/openssl \
--with-default-user=${USER} \
--with-swapdir=/dev/null \
--with-pidfile=/var/run/${APP_NAME}.pid \
--with-logdir=/var/log/${APP_NAME} \
|| die 0 "[${APP_NAME}] Configure failed"

# --with-swapdir=/dev/null \
# --with-swapdir=/var/spool/squid \
# --with-gnutls

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER};
