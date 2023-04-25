#!/bin/bash

# Dependencies which must exist prior to current build. If not found, will try to install
DEPENDENCIES=(openssl pcre libxml2 libxslt libgd GeoIP gperftools);

# build data
VERSION="1.24.0";
DIST_URL="https://nginx.org/download/nginx-${VERSION}.tar.gz";
APP_NAME="nginx";
USER="${APP_NAME}";

source ./helpers/build_pre/.pre-start.sh;

./configure \
--prefix=${DESTINATION} \
--conf-path=${ETC_DIR}/${APP_NAME}/nginx.conf \
--http-log-path=/var/log/${APP_NAME}/access.log \
--error-log-path=/var/log/${APP_NAME}/error.log \
--lock-path=/var/run/lock/subsys/${APP_NAME}.lock \
--pid-path=/var/run/${APP_NAME}.pid \
--http-client-body-temp-path=${DESTINATION}/lib/body \
--http-fastcgi-temp-path=${DESTINATION}/lib/fastcgi \
--http-proxy-temp-path=${DESTINATION}/lib/proxy \
--http-scgi-temp-path=${DESTINATION}/lib/scgi \
--http-uwsgi-temp-path=${DESTINATION}/lib/uwsgi \
--user=${USER} \
--group=${USER} \
--with-file-aio \
--with-google_perftools_module \
--with-http_addition_module \
--with-http_dav_module \
--with-http_degradation_module \
--with-http_geoip_module \
--with-http_gzip_static_module \
--with-http_image_filter_module \
--with-http_perl_module \
--with-http_random_index_module \
--with-http_realip_module \
--with-http_secure_link_module \
--with-http_spdy_module \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_sub_module \
--with-http_xslt_module \
--with-http_v2_module \
--with-ipv6 \
--without-mail_imap_module \
--without-mail_smtp_module \
--with-sha1=${BIN_DIR}/openssl/include \
--with-md5=${BIN_DIR}/openssl/include \
--with-cc-opt="-D FD_SETSIZE=32768' -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -I${BIN_DIR}/libxml2/include/libxml2 -I${BIN_DIR}/libxslt/include -I${BIN_DIR}/libgd/include -I${BIN_DIR}/GeoIP/include -I${BIN_DIR}/gperftools/include -I${BIN_DIR}/pcre/include -I${BIN_DIR}/openssl/include -I${BIN_DIR}/zlib/include" \
--with-ld-opt="-Wl,-z,relro -Wl,--as-needed -L${BIN_DIR}/libxml2/lib -L${BIN_DIR}/libxslt/lib -L${BIN_DIR}/libgd/lib -L${BIN_DIR}/GeoIP/lib -L${BIN_DIR}/gperftools/lib -L${BIN_DIR}/pcre/lib -L${BIN_DIR}/openssl/lib64 -L${BIN_DIR}/zlib/lib" \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";
echo "Trying to make ${APP_NAME}...";
make || die 0 "[${APP_NAME}] Make failed";

make install || die 0 "[${APP_NAME}] Make install failed";
echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION} ${USER};
