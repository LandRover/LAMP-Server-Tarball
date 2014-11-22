#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

APP_DIR="${BIN_DIR}/${APP_NAME}-${VERSION}";
USER="$4";
DATA_DIR="$5";
PASSWORD="$6"; ## mysql root password
HOME_DIR="/home/${USER}";
ETC_DIR="/opt/local/etc";
[[ -z "${USER}" || -z "${DATA_DIR}" ]] && usage "[error] User was not set. Halt. As mysql setup requires a user.";

## init.d symlinks
../helpers/bin/ln.sh ${BIN_DIR}/${APP_NAME}/support-files/mysql.server ${ETC_DIR}/init.d/${APP_NAME};
../helpers/post_etc_ln.sh "${ETC_DIR}" "init.d" "${APP_NAME}";

## system stop/start on boot
update-rc.d ${APP_NAME} defaults

## create user and group
[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d ${HOME_DIR} ${USER};

# Verify home dir for user exists.
[ ! -d "${HOME_DIR}" ] && mkdir -p "${HOME_DIR}";

# Verify /var/run/mysql
[ ! -d "/var/run/${APP_NAME}" ] && mkdir "/var/run/${APP_NAME}";
chown -R ${USER}:${USER} /var/run/${APP_NAME}; ##change sock dir owner

# If no data, means it's a fresh install and not an update so create initial setup - happens only once
# wont be triggered during rebuilds
if [ ! -d "${HOME_DIR}/${DATA_DIR}" ]; then
    ## profile.d
    ../helpers/post_etc_ln.sh "${ETC_DIR}" "profile.d" "${APP_NAME}.sh";
    
    ## Copy template of .my.cnf to ~
    cp -Lf ../templates/mysql/.my.cnf ~/.my.cnf

    ## bash must be in dir before running mysql_install_db since ./bin/my_print_defaults is called relatively, blah.
    cd ${BIN_DIR}/${APP_NAME};

    ## generate default structure to datadir
    ./scripts/mysql_install_db --user=${USER} --ldata=${HOME_DIR}/${DATA_DIR};

    chown -R ${USER}:${USER} ${BIN_DIR}/${APP_NAME};
    chown -R ${USER}:${USER} ${APP_DIR};
    chown -R ${USER}:${USER} ${HOME_DIR};

    ## start the server..
    /etc/init.d/${APP_NAME} restart

    if [ ! -z "${PASSWORD}" ]; then
        ## change default password
        ${BIN_DIR}/${APP_NAME}/bin/mysqladmin -u root password "${PASSWORD}";
        ${BIN_DIR}/${APP_NAME}/bin/mysqladmin -u root -h 127.0.0.1 password "${PASSWORD}";

        ## set generated password to keep in file. allows auto login via mysql command and mysqldump
        sed -i "s/\$PASSWORD/${PASSWORD}/g" ~/.my.cnf;
    fi
fi

## restart service
/etc/init.d/${APP_NAME} restart