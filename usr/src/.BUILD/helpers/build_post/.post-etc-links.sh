#!/bin/bash

#[ ["$0" = "${BASH_SOURCE}"] || ["$1" = "${BASH_SOURCE}"] ] && echo "FILE CAN ONLY BE SOURCED, DIRECT EXECUTION IS NOT ALLOWED!" && exit 0;

echo "[INFO] Add app to profile.d";
if [ -d "/opt/local/sbin/${APP_NAME}/bin" ] || [ -d "/opt/local/sbin/${APP_NAME}/sbin" ]; then
    echo "[INFO] Generating profile.d for ${APP_NAME}";

    # Start with the base export statement
    export_statement="export PATH=\$PATH"

    # Check if /bin directory exists and add it to PATH
    if [ -d "/opt/local/sbin/${APP_NAME}/bin" ]; then
        export_statement="${export_statement}:/opt/local/sbin/${APP_NAME}/bin"
    fi

    # Check if /sbin directory exists and add it to PATH
    if [ -d "/opt/local/sbin/${APP_NAME}/sbin" ]; then
        export_statement="${export_statement}:/opt/local/sbin/${APP_NAME}/sbin"
    fi

    # Write the export statement to the profile.d file
    echo -e "${export_statement}" > "/etc/profile.d/${APP_NAME}.sh";
fi

echo "[INFO] Checking tmpfiles.d ln to etc";
APP_TMPFILES="${ETC_DIR}/tmpfiles.d/${APP_NAME}.conf";
if [ -f "${APP_TMPFILES}" ]; then
    echo "[INFO] Found ${APP_TMPFILES}, creating ln";
    ../post_etc_ln.sh "${ETC_DIR}" "tmpfiles.d" "${APP_NAME}.conf";
fi

echo "[INFO] Checking logrotate.d ln to etc";
APP_LOGROTATE="${ETC_DIR}/logrotate.d/${APP_NAME}";
if [ -f "${APP_LOGROTATE}" ]; then
    echo "[INFO] Found ${APP_LOGROTATE}, creating ln";
    ../post_etc_ln.sh "${ETC_DIR}" "logrotate.d" "${APP_NAME}";
fi

echo "[INFO] Checking ld.so";
APP_LIB="${BIN_DIR}/${APP_NAME}/lib";
if [ -d "${APP_LIB}" ]; then
    echo "[INFO] Found ${APP_LIB}, creating file";
    echo "${APP_LIB}" > "/etc/ld.so.conf.d/${APP_NAME}.conf";
    /sbin/ldconfig ${APP_LIB};
fi

echo "[INFO] Checking ld.so lib64";
APP_LIB64="${BIN_DIR}/${APP_NAME}/lib64";
if [ -d "${APP_LIB64}" ]; then
    echo "[INFO] Found ${APP_LIB64}, creating file";
    echo "${APP_LIB64}" > "/etc/ld.so.conf.d/${APP_NAME}.conf";
    /sbin/ldconfig ${APP_LIB64};
fi

echo "[INFO] Checking include";
APP_INCLUDE="${BIN_DIR}/${APP_NAME}/include";
if [ -d "${APP_INCLUDE}" ]; then
    echo "[INFO] Found ${APP_INCLUDE}, creating ln";
    ../bin/ln.sh ${APP_INCLUDE} /usr/include/${APP_NAME};
fi

echo "[INFO] Checking etc";
APP_ETC="${ETC_DIR}/${APP_NAME}";
if [ -d "${APP_ETC}" ]; then
    echo "[INFO] Found ${APP_ETC}, creating ln";
    ../bin/ln.sh "${APP_ETC}" "/etc/${APP_NAME}";
fi

echo "[INFO] Checking init.d ln to etc";
APP_INIT="${ETC_DIR}/init.d/${APP_NAME}";
if [ -f "${APP_INIT}" ]; then
    echo "[INFO] Found ${APP_INIT}, creating ln";
    ../post_etc_ln.sh "${ETC_DIR}" "init.d" "${APP_NAME}";

    ## system stop/start on boot
    echo "[INFO] Adding ${APP_NAME} to startup";
    update-rc.d ${APP_NAME} defaults

    echo "[INFO] Retarting service ${APP_NAME}";
    /etc/init.d/${APP_NAME} restart
fi
