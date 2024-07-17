#!/bin/bash

POST_DIR="`pwd`";

APP_FILE="$1";
BIN_DIR="$2";
ETC_DIR="$3";
APP_NAME="$4";
VERSION="$5";

PARAM1="$6";
PARAM2="$7";
PARAM3="$8";

APP_DIR="${BIN_DIR}/${APP_NAME}";
APP_FULL_DIR="${APP_DIR}-${VERSION}";
