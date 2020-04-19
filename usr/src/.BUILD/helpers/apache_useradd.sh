#!/bin/bash

USER="$1";
DOMAIN="$2";
PRIORITY="$3";
HOME_DIR="/home/${USER}";
DEFAULT_HTDOCS="${HOME_DIR}/public_html";
DEFAULT_PORT="80";
DEFAULT_IS_SSL="0";
HTDOCS="${4:-$DEFAULT_HTDOCS}";
PORT="${5:-$DEFAULT_PORT}";
IS_SSL="${6:-$DEFAULT_IS_SSL}";
BUILD="$(dirname ${BASH_SOURCE[0]})/..";

BASE_PORT="9000";
CGI_PORT="$(expr ${BASE_PORT} + ${PRIORITY})"; ## calc fcgi port

ETC_DIR="/opt/local/etc";
ETC_PHPFPMD="${ETC_DIR}/php/fpm.d";
ETC_HTTPD_VHOST="${ETC_DIR}/apache/vhosts";

APACHE_LOGS_DIR="/home/${USER}/logs";

TEMPLATE_PHPFPM="${BUILD}/helpers/templates/php/php-fpm-template.conf";
TEMPLATE_APACHE="${BUILD}/helpers/templates/apache/vhost-template.conf";

TARGET_PHPFPM_FILE="${ETC_PHPFPMD}/${USER}.conf";
TARGET_APACHE_FILE="${ETC_HTTPD_VHOST}/$(printf '%03d' ${PRIORITY})-${USER}.conf";

VARLIST=(USER HOME_DIR HTDOCS DOMAIN PORT CGI_PORT);

## if ssl, renames to -ssl.conf
[ "1" -eq "${IS_SSL}" ] && TARGET_APACHE_FILE="${TARGET_APACHE_FILE/.conf/-ssl.conf}";

function usage {
    if [ ! -z "$1" ]; then
        echo $1;
        echo "";
    fi

    echo "USAGE: $0 <user> <domain> <priority> [htdocs] [port] [is_ssl]";
    echo "";
    echo "<user> - user who will own this property. (example: foobar)";
    echo "<domain> - domain name to listen";
    echo "<priority> - loading order priority, also controls the php-fpm tcp listen port, 3 digits. order: ASC. (Example: 000, 001.. etc)";
    echo "[htdocs] - Custom path to user's local htdocs. Optional, default: /home/USER/public_html";
    echo "[port] - port to bind apache to listen at. default: 80";
    echo "[is_ssl] - generates params for ssl, default: 0, 1 if set.";
    echo "";

    exit 0;
}

## validation inputs
[[ -z "${USER}" || -z "${DOMAIN}" || $PRIORITY != ?(-)+([0-9.]) || $PORT != ?(-)+([0-9.]) || $IS_SSL != ?(-)+([0-1.]) ]] && usage;

[ -z "$(getent passwd ${USER})" ] && echo "[info] User ${USER} not found, creating.." && useradd -M -s /bin/false -d ${HOME_DIR} ${USER};

echo "[info] Checking htdocs dir @ ${HTDOCS}";
[ ! -d "${HTDOCS}" ] && echo "[info] htdocs not found, creating ${HTDOCS}" && mkdir -p ${HTDOCS} && echo "<html><body><h1>It works!</h1></body></html>" > ${HTDOCS}/index.html && chmod -R 600 ${HOME_DIR} && chown -R ${USER}:${USER} ${HOME_DIR} && chmod 711 ${HOME_DIR};

echo "[info] Checking logs dir @ ${APACHE_LOGS_DIR}";
[ ! -d "${APACHE_LOGS_DIR}" ] && echo "[info] logs dir not found, creating ${APACHE_LOGS_DIR}" && mkdir -p ${APACHE_LOGS_DIR} && chown -R ${USER}:${USER} ${APACHE_LOGS_DIR} && chmod -R u+w ${APACHE_LOGS_DIR};

echo "[info] Copy PHP-FPM Template ${TARGET_PHPFPM_FILE}";
cp -Lf ${TEMPLATE_PHPFPM} ${TARGET_PHPFPM_FILE};

echo "[info] Copy Apache Template ${TARGET_APACHE_FILE}";
cp -Lf ${TEMPLATE_APACHE} ${TARGET_APACHE_FILE};

echo "[info] Start making template params";
for i in ${VARLIST[@]}; do
    echo "Replacing \$$i -> ${!i}";
    sed -i "s/\$$i/${!i//\//\\/}/g" ${TARGET_PHPFPM_FILE};
    sed -i "s/\$$i/${!i//\//\\/}/g" ${TARGET_APACHE_FILE};
done

# DEBUG - COMMAND LINE USED
sed -i "s/\$COMMAND_LINE/$@/g" ${TARGET_PHPFPM_FILE};
sed -i "s/\$COMMAND_LINE/$@/g" ${TARGET_APACHE_FILE};

## for localhost no need to add servername and alias.
[ ${DOMAIN} == "localhost" ] && sed -i "s/ServerAlias localhost www\.localhost//g" ${TARGET_APACHE_FILE};

echo "[info] Done making the template";