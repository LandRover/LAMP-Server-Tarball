#!/bin/bash

USER="$1";
DOMAIN="$2";
PRIORITY="$3";
DEFAULT_HTDOCS="/home/${USER}/public_html";
DEFAULT_PORT="80";
DEFAULT_IS_SSL="0";
HTDOCS="${4:-$DEFAULT_HTDOCS}";
PORT="${5:-$DEFAULT_PORT}";
IS_SSL="${6:-$DEFAULT_IS_SSL}";
BUILD="$(dirname ${BASH_SOURCE[0]})/..";
TEMPLATE_PHPFPM="{BUILD}/templates/php/php-fpm-template.conf";
TEMPLATE_APACHE="{BUILD}/templates/apache/vhost-template.conf";
ETC_DIR="/opt/local/etc";
ETC_PHPFPMD="${ETC_DIR}/php/fpm.d";
ETC_HTTPD_VHOST="${ETC_DIR}/apache/vhosts";
TARGET_PHPFPM_FILE="${ETC_PHPFPMD}/${USER}.conf";
TARGET_APACHE_FILE="${ETC_HTTPD_VHOST}/${PRIORITY}-${USER}.conf";

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

echo "ok";