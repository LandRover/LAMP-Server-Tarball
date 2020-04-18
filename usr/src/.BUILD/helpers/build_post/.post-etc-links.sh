#!/bin/bash

#[ ["$0" = "${BASH_SOURCE}"] || ["$1" = "${BASH_SOURCE}"] ] && echo "FILE CAN ONLY BE SOURCED, DIRECT EXECUTION IS NOT ALLOWED!" && exit 0;

echo "[info] Checking profile.d ln to etc";
APP_PROFILE="${ETC_DIR}/profile.d/${APP_NAME}.sh";
if [ -f "${APP_PROFILE}" ]; then
    echo "[info] Found ${APP_PROFILE}, creating ln";
    ../post_etc_ln.sh "${ETC_DIR}" "profile.d" "${APP_NAME}.sh";
fi

echo "[info] Checking tmpfiles.d ln to etc";
APP_TMPFILES="${ETC_DIR}/tmpfiles.d/${APP_NAME}.conf";
if [ -f "${APP_TMPFILES}" ]; then
    echo "[info] Found ${APP_TMPFILES}, creating ln";
    ../post_etc_ln.sh "${ETC_DIR}" "tmpfiles.d" "${APP_NAME}.conf";
fi

echo "[info] Checking logrotate.d ln to etc";
APP_LOGROTATE="${ETC_DIR}/logrotate.d/${APP_NAME}";
if [ -f "${APP_LOGROTATE}" ]; then
    echo "[info] Found ${APP_LOGROTATE}, creating ln";
    ../post_etc_ln.sh "${ETC_DIR}" "logrotate.d" "${APP_NAME}";
fi

echo "[info] Checking ld.so";
APP_LIB="${BIN_DIR}/${APP_NAME}/lib";
if [ -d "${APP_LIB}" ]; then
    echo "[info] Found ${APP_LIB}, creating file";
    echo "${APP_LIB}" > "/etc/ld.so.conf.d/${APP_NAME}.conf";
    /sbin/ldconfig ${APP_LIB};
fi

echo "[info] Checking include";
APP_INCLUDE="${BIN_DIR}/${APP_NAME}/include";
if [ -d "${APP_INCLUDE}" ]; then
    echo "[info] Found ${APP_INCLUDE}, creating ln";
    ../bin/ln.sh ${APP_INCLUDE} /usr/include/${APP_NAME};
fi

echo "[info] Checking etc";
APP_ETC="${ETC_DIR}/${APP_NAME}";
if [ -d "${APP_ETC}" ]; then
    echo "[info] Found ${APP_ETC}, creating ln";
    ../bin/ln.sh "${APP_ETC}" "/etc/${APP_NAME}";
fi

echo "[info] Checking init.d ln to etc";
APP_INIT="${ETC_DIR}/init.d/${APP_NAME}";
if [ -f "${APP_INIT}" ]; then
    echo "[info] Found ${APP_INIT}, creating ln";
    ../post_etc_ln.sh "${ETC_DIR}" "init.d" "${APP_NAME}";

    ## system stop/start on boot
    echo "[info] Adding ${APP_NAME} to startup";
    update-rc.d ${APP_NAME} defaults

    echo "[info] Retarting service ${APP_NAME}";
    /etc/init.d/${APP_NAME} restart
fi
