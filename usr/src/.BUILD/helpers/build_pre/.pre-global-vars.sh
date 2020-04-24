#!/bin/bash

[ "$0" = "${BASH_SOURCE}" ] && echo "FILE CAN ONLY BE SOURCED, DIRECT EXECUTION IS NOT ALLOWED!" && exit 0;

# destination build info
BUILD="`pwd`";
LOCAL="/opt/local";
BIN_DIR="${LOCAL}/sbin";
ETC_DIR="${LOCAL}/etc";
DESTINATION="${BIN_DIR}/${APP_NAME}-${VERSION}";

if [ "`cat /proc/cpuinfo | grep -F 'model name' | wc -l`" -gt 0 ]; then
    CPU_CORES="`cat /proc/cpuinfo | grep -F 'model name' | wc -l`"
fi
MEMORY=`grep -m1 'MemTotal' /proc/meminfo | awk '{print $2}'`

die() {
  local code=$? now=$(date +%T.%N)
  if [ "$1" -ge 0 ] 2>/dev/null; then  # assume $1 is an error code if numeric
    code="$1"
    shift
  fi
  echo "$0: ERROR at ${now%???}${1:+: $*}" >&2
  exit $code
}