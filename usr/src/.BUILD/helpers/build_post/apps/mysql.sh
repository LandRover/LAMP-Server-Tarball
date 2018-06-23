#!/bin/bash

USER="${PARAM1}";
DATA_DIR="${PARAM2}";
PASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w8 | head -n1); ## mysql root password
HOME_DIR="/home/${USER}";
TMP_INIT_FILE='/tmp/.reset-mysql-pw.sql';
[[ -z "${USER}" || -z "${DATA_DIR}" ]] && usage "[error] User was not set. Halt. As mysql setup requires a user.";

## create user and group
[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d ${HOME_DIR} ${USER};

# Verify home dir for user exists.
[ ! -d "${HOME_DIR}" ] && mkdir -p "${HOME_DIR}";

# Verify /var/run/mysql
[ ! -d "/var/run/${APP_NAME}" ] && mkdir "/var/run/${APP_NAME}";
chown -R ${USER}:${USER} /var/run/${APP_NAME}; # Change mysql.sock permission

# Create dir for logs
[ ! -d "${HOME_DIR}/logs" ] && mkdir "${HOME_DIR}/logs";
chown -R ${USER}:${USER} ${HOME_DIR}/logs; # Change logs permission

# If no data, means it's a fresh install and not an update so create initial setup - happens only once
# wont be triggered during rebuilds
if [ ! -d "${HOME_DIR}/${DATA_DIR}" ]; then
echo "OGZzzzzzzzzzz";
ls
    ## Copy template of .my.cnf to ~
    cp -Lf ../../helpers/templates/mysql/.my.cnf ~/.my.cnf
    cp -Lf ../../helpers/templates/mysql/.init-file ${TMP_INIT_FILE};

    ## bash must be in dir before running mysql_install_db since ./bin/my_print_defaults is called relatively, blah.
    cd ${BIN_DIR}/${APP_NAME};

    ## generate default structure to datadir
    ${BIN_DIR}/${APP_NAME}/bin/mysqld \
        --user=${USER} \
        --initialize;

    ${BIN_DIR}/${APP_NAME}/bin/mysql_ssl_rsa_setup;

    chown -R ${USER}:${USER} ${BIN_DIR}/${APP_NAME};
    chown -R ${USER}:${USER} ${APP_DIR};
    chown -R ${USER}:${USER} ${HOME_DIR};

    ## start the server..
    ${ETC_DIR}/init.d/${APP_NAME} stop

    if [ ! -z "${PASSWORD}" ]; then
        echo "[info] Reseting password to: ${PASSWORD}";
        ## set generated password to keep in file. allows auto login via mysql command and mysqldump
        sed -i "s/\$PASSWORD/${PASSWORD}/g" ~/.my.cnf;
        sed -i "s/\$PASSWORD/${PASSWORD}/g" ${TMP_INIT_FILE};

        ${BIN_DIR}/${APP_NAME}/bin/mysqld --defaults-file=${ETC_DIR}/mysql/my.cnf --init-file=${TMP_INIT_FILE} &
        sleep 3;
        rm -rf ${TMP_INIT_FILE};
    fi
fi

## restart service
${ETC_DIR}/init.d/${APP_NAME} restart