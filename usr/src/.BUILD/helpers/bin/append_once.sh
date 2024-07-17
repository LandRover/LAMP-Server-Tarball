#!/bin/bash

FILE=$1
STRING=$2
COMMENT=${3:-}

usage() {
    echo "Usage: $0 <file> <string> [comment]";
    exit 1
}

append_if_not_exists() {
    local FILENAME=$1;
    local APPEND_TEXT=$2;
    local COMMENT_TEXT=$3;

    # Check if the string is already in the file
    if [ ! -f "${FILENAME}" ] || ! grep -Fxq "${APPEND_TEXT}" "${FILENAME}"; then
        echo "" >> "${FILENAME}";

        # Append the comment if it is not empty
        if [ -n "${COMMENT_TEXT}" ]; then
            echo "# ${COMMENT_TEXT}" >> "${FILENAME}";
        fi

        echo "${APPEND_TEXT}" >> "${FILENAME}";
        echo "" >> "${FILENAME}";

        if [ $? -eq 0 ]; then
            return 0
        else
            return 1
        fi
    fi
}

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    usage
fi

# Call the function to append the string if it doesn't exist
append_if_not_exists "${FILE}" "${STRING}" "${COMMENT}"
APPEND_STATUS=$?

if [ ${APPEND_STATUS} -eq 0 ]; then
    echo "[INFO] Append finished successfully to '${FILE}'.";
else
    echo "[ERROR] Append failed to '${FILE}' and text of '${STRING}'.";
fi
