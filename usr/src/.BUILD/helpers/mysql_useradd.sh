#!/bin/bash

DBNAME="$1";
DBUSER="$2";
E_BADARGS="65";
RANDOM_PASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w8 | head -n1);
DBPASS="${3:-$RANDOM_PASSWORD}";
MSQL_BIN="/opt/local/sbin/mysql/bin/mysql";

function usage {
    if [ ! -z "$1" ]; then
        echo $1;
        echo "";
    fi

    echo "USAGE: $0 <db_name> <db_user> [db_pass]";
    echo "";
    echo "<db_name> - Database name.";
    echo "<db_user> - Database username.";
    echo "[db_pass] - If password not set, will generate a random password.";
    echo "";

    exit ${E_BADARGS};
}

## validation inputs
[[ -z "${DBNAME}" || -z "${DBUSER}" || -z "${DBPASS}" ]] && usage;

Q1="CREATE DATABASE IF NOT EXISTS ${DBNAME};";
Q2="CREATE USER '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPASS}';";
Q3="GRANT ALL ON ${DBNAME}.* TO '${DBUSER}'@'localhost';";
Q4="FLUSH PRIVILEGES;";
SQL="${Q1}${Q2}${Q3}${Q4}";

$MSQL_BIN -uroot -e "${SQL}";

echo "[info] User created with the following:";
echo "    DB IP: localhost";
echo "    DB NAME: ${DBNAME}";
echo "    DB USERNAME: ${DBUSER}";
echo "    DB PASSWORD: ${DBPASS}";
echo "";
