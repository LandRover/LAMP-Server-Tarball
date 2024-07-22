#!/bin/bash

# build data
VERSION="1.2.11";
DIST_URL="https://cdn.netbsd.org/pub/pkgsrc/distfiles/LOCAL_PORTS/libspf2-${VERSION}.tar.gz";
APP_NAME="libspf2";

source ./helpers/build_pre/.pre-start.sh;

COMPILE_FROM_SOURCE=true;

[ "$COMPILE_FROM_SOURCE" != true ] && apt-get -y install spf-tools-perl;

## has internal dir, move up
[ -d "${APP_NAME}-${VERSION}" ] && mv ${APP_NAME}-${VERSION}/* . && rm -rf ${APP_NAME}-${VERSION};

## won't compile without - pending pull request fix: https://github.com/shevek/libspf2/pull/5/files
perl -pi -e 's|SPF_debugx\( __FILE__, __LINE__, format, __VA_ARGS__ \)|SPF_debugx\( __FILE__, __LINE__, format, ##__VA_ARGS__ \)|g' ./src/include/spf_log.h
perl -pi -e 's|www.openspf.org|www.open-spf.org|g' ./src/include/spf.h

# Handle patch
PATCH_PATH="";
PATCH_FILES=("0001-remove-libreplace-unneeded-on-Linux.patch" "0002-add-include-string-for-memset.patch" "0003-CVE-2023-42118-and-other-fixes.patch")
for i in "${!PATCH_FILES[@]}"; do
        PATCH_FILE=${PATCH_FILES[i]};
        PATCH_LOCK_FILE="${PATCH_FILE}.lock";

        # Check if the lock file exists for this target file
        if [ -f "${PATCH_LOCK_FILE}" ]; then
                echo "The patch for ${PATCH_FILE} has already been applied. Skipping."
                continue
        fi

        echo "Patching ${PATCH_FILE}...";
        patch -p1 < "${BUILD}/helpers/templates/${APP_NAME}/patch/${PATCH_FILE}";
        if [ $? -eq 0 ]; then
                echo "Successfully patched ${PATCH_FILE}";
                touch "${PATCH_LOCK_FILE}";
        else
                echo "Failed to patch ${PATCH_FILE}";
        fi
done

autoreconf -vif;

# using --disable-static does not build
./configure \
--prefix=${DESTINATION} \
--host=x86_64-linux-gnu \
--enable-perl \
--disable-dependency-tracking \
|| die 0 "[${APP_NAME}] Configure failed";

echo "Done. Making ${APP_NAME}-${VERSION}...";

echo "Trying to make ${APP_NAME}...";

make \
PERL_INSTALL_ROOT=$(grep DESTDIR perl/Makefile &> /dev/null && echo "" || echo ${DESTINATION}) \
INSTALLDIRS=vendor \
INSTALL="install -p" \
install || die 0 "[${APP_NAME}] Make install failed";

echo "Done ${APP_NAME}.";

cd ${BUILD}/helpers/build_post && /bin/bash ./.post-start.sh $0 ${BIN_DIR} ${ETC_DIR} ${APP_NAME} ${VERSION};
