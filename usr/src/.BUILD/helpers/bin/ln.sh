#!/bin/bash

SRC="$1";
DST="$2";

function usage {
    if [ ! -z "$1" ]; then
        echo $1;
        echo "";
    fi

    echo "USAGE: $0 <src> <dst>";
    echo "";
    echo "<src> - source dir for the link";
    echo "<dst> - destination dir for link";
    echo "";

    exit 0;
}

# validation on input
[[ -z "${SRC}" || -z "${DST}" ]] && usage;
[ ! -d "${SRC}" ] && usage "[error] Soruce dir, ${SRC}, not found. Fix it and try again.";

if [ -d "${DST}" ]; then
    echo "[info] Existing symlink detected at ${DST}. Removing old link..";
    rm -rf ${DST};
    echo "[info] ${DST} Removed old link.";
fi

echo "[info] Creating link ${DST}";
ln -s ${SRC} ${DST};
echo "[info] Link created ${DST} -> ${SRC}";
