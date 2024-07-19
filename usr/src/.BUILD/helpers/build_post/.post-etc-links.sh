#!/bin/bash

#[ ["$0" = "${BASH_SOURCE}"] || ["$1" = "${BASH_SOURCE}"] ] && echo "FILE CAN ONLY BE SOURCED, DIRECT EXECUTION IS NOT ALLOWED!" && exit 0;

echo "[INFO] Checking Link lib64 to lib if doesnt exist";
if [ -d "${BIN_DIR}/${APP_NAME}/lib64" ] || [ ! -d "${BIN_DIR}/${APP_NAME}/lib" ]; then
    echo "[INFO] lib folder is missing while lib64 exists, linking...";
    ../bin/ln.sh ${BIN_DIR}/${APP_NAME}/lib64 ${BIN_DIR}/${APP_NAME}/lib;;
fi

echo "[INFO] Add app to profile.d";
if [ -d "${BIN_DIR}/${APP_NAME}/bin" ] || [ -d "${BIN_DIR}/${APP_NAME}/sbin" ]; then
    echo "[INFO] Generating profile.d for ${APP_NAME}";

    # Start with the base export statement
    export_statement="export PATH=\$PATH";

    # Check if /bin directory exists and add it to PATH
    if [ -d "${BIN_DIR}/${APP_NAME}/bin" ]; then
        export_statement="${export_statement}:${BIN_DIR}/${APP_NAME}/bin";
    fi

    # Check if /sbin directory exists and add it to PATH
    if [ -d "${BIN_DIR}/${APP_NAME}/sbin" ]; then
        export_statement="${export_statement}:${BIN_DIR}/${APP_NAME}/sbin";
    fi

    # Write the export statement to the profile.d file
    echo -e "${export_statement}" > "/etc/profile.d/${APP_NAME}.sh";
fi

echo "[INFO] Checking tmpfiles.d ln to etc";
APP_TMPFILES="${ETC_DIR}/tmpfiles.d/${APP_NAME}.conf";
if [ -f "${APP_TMPFILES}" ]; then
    echo "[INFO] Found ${APP_TMPFILES}, creating link";
    ../post_etc_ln.sh "${ETC_DIR}" "tmpfiles.d" "${APP_NAME}.conf";
fi

echo "[INFO] Checking logrotate.d ln to etc";
APP_LOGROTATE="${ETC_DIR}/logrotate.d/${APP_NAME}";
if [ -f "${APP_LOGROTATE}" ]; then
    echo "[INFO] Found ${APP_LOGROTATE}, creating link ${APP_NAME}/etc/logrotate.d to /etc/logrotate.d/${APP_NAME}";
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
    echo "[INFO] Found ${APP_INCLUDE}, creating link from ${APP_NAME}/include to /usr/include/${APP_NAME}";
    ../bin/ln.sh ${APP_INCLUDE} /usr/include/${APP_NAME};
fi

echo "[INFO] Checking etc";
APP_ETC="${ETC_DIR}/${APP_NAME}";
if [ -d "${APP_ETC}" ]; then
    echo "[INFO] Found ${APP_ETC}, creating link ${APP_NAME}/etc to /etc/${APP_NAME}";
    ../bin/ln.sh "${APP_ETC}" "/etc/${APP_NAME}";
fi

echo "[INFO] Checking init.d ln to etc";
APP_INIT="${ETC_DIR}/init.d/${APP_NAME}";
if [ -f "${APP_INIT}" ]; then
    echo "[INFO] Found ${APP_INIT}, creating link from ${APP_NAME}/etc/init.d to /etc/init.d";
    ../post_etc_ln.sh "${ETC_DIR}" "init.d" "${APP_NAME}";

    echo "[INFO] Adding ${APP_NAME} to system startup";
    update-rc.d ${APP_NAME} defaults

    echo "[INFO] Retarting service ${APP_NAME}";
    /etc/init.d/${APP_NAME} restart
fi
