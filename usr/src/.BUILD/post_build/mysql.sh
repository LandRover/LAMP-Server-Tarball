#!/bin/bash

source ../helpers/.post_validate_input.sh;
source ./.shared.sh;

APP_DIR="${BIN_DIR}/${APP_NAME}-${VERSION}";
USER="$4";
DATA_DIR="$5";
HOME_DIR="/home/${USER}";
[[ -z "${USER}" || -z "${DATA_DIR}" ]] && usage "[error] User was not set. Halt. As mysql setup requires a user.";

../helpers/bin/ln.sh ${BIN_DIR}/${APP_NAME}/support-files/mysql.server /opt/local/etc/init.d/${APP_NAME};
../helpers/bin/ln.sh /opt/local/etc/init.d/${APP_NAME} /etc/init.d/${APP_NAME};

groupadd ${USER};
useradd -d ${HOME_DIR} -g ${USER} -s /bin/false ${USER};

# Verify home dir for user exists.
[ ! -d "${HOME_DIR}" ] && mkdir "${HOME_DIR}";

# Verify /var/run/mysql
[ ! -d "/var/run/${APP_NAME}" ] && mkdir "/var/run/${APP_NAME}" && chown -R ${USER}:${USER} /var/run/${APP_NAME};

# If no data, means it's a fresh install and not an update so create initial setup
if [ ! -d "${HOME_DIR}/${DATA_DIR}" ]; then
    cd ${BIN_DIR}/${APP_NAME};

    ./scripts/mysql_install_db --user=${USER} --ldata=${HOME_DIR}/${DATA_DIR};

    chown -R ${USER}:${USER} ${BIN_DIR}/${APP_NAME};
    chown -R ${USER}:${USER} ${APP_DIR};
    chown -R ${USER}:${USER} ${HOME_DIR};

    /etc/init.d/${APP_NAME} restart

    ./bin/mysqladmin -u root password 'new-password-here';
    ./bin/mysqladmin -u root -h 127.0.0.1 password 'new-password-here';
fi