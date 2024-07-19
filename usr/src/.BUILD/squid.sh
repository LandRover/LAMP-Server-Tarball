#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl gnutls libecap libxml2);

# build data
VERSION="6.10";
DIST_URL="http://www.squid-cache.org/Versions/v6/squid-${VERSION}.tar.gz";
APP_NAME="squid";
USER="${APP_NAME}";

source ./helpers/build_pre/.pre-start.sh;

## Create user for squid
[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d /dev/null ${USER};

./configure \
--prefix=${DESTINATION} \
--sysconfdir=${ETC_DIR}/${APP_NAME} \
CPPFLAGS="-I${BIN_DIR}/gnutls/include -I${BIN_DIR}/nettle/include" \
LDFLAGS="-L${BIN_DIR}/gnutls/lib -lgnutls" \
EXT_LIBECAP_CFLAGS="-I${BIN_DIR}/libecap/include" \
EXT_LIBECAP_LIBS="-L${BIN_DIR}/libecap/lib -lecap" \
LIBXML2_CFLAGS="-I${BIN_DIR}/libxml2/include/libxml2" \
LIBXML2_LIBS="-L${BIN_DIR}/libxml2/lib -lxml2" \
LIBGNUTLS_CFLAGS="-I${BIN_DIR}/gnutls/include" \
LIBGNUTLS_LIBS="-L${BIN_DIR}/gnutls/lib -lgnutls" \
LIBNETTLE_CFLAGS="-I${BIN_DIR}/nettle/include" \
LIBNETTLE_LIBS="-L${BIN_DIR}/nettle/lib -lnettle" \
--disable-maintainer-mode \
--disable-dependency-tracking \
--disable-silent-rules \
--disable-arch-native \
--disable-translation \
--enable-build-info="Latest Custom Build (${VERSION})" \
--enable-http-violations \
--enable-inline \
--enable-async-io=8 \
--enable-storeio="ufs,aufs,diskd,rock" \
--enable-removal-policies="lru,heap" \
--enable-ssl \
--enable-ssl-crtd \
--enable-ecap \
--enable-icap-client \
--enable-linux-netfilter \
--enable-auth-basic="DB,fake,NCSA" \
--enable-auth-digest=file \
--enable-auth-negotiate="wrapper" \
--enable-auth-ntlm=fake \
--enable-external-acl-helpers="file_userip" \
--enable-security-cert-validators=fake \
--enable-storeid-rewrite-helpers=file \
--enable-url-rewrite-helpers=fake \
--with-large-files \
--with-openssl=${BIN_DIR}/openssl \
--with-gnutls=${BIN_DIR}/gnutls \
--with-default-user=${USER} \
--with-swapdir=/dev/null \
--with-pidfile=/var/run/${APP_NAME}.pid \
--with-logdir=/var/log/${APP_NAME} \
|| die 0 "[${APP_NAME}] Configure failed"

# --with-swapdir=/dev/null \
# --with-swapdir=/var/spool/squid \

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER};
