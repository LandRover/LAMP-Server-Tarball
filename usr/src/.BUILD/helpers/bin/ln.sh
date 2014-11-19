#!/bin/bash

#!/bin/bash

SRC="$1";
DST="$2";

function usage {
    echo "";
    echo "USAGE: $0 <src> <dst>";
    echo "";
    echo "<src> - source dir for the link";
    echo "<dst> - destination dir for link";
    echo "";

    exit 0;
}

[[ -z "${SRC}" || -z "${DST}" ]] && usage;

if [ ! -d "${SRC}" ]; then
    echo "[error] Soruce dir, ${SRC}, not found. Fix it and try again.";
    usage;
fi

if [ -d "${DST}" ]; then
    echo "[info] Existing symlink detected at ${DST}. Removing..";
    rm -rf ${DST};
    echo "[info] ${DST} Removed link.";
fi

echo "[info] Creating link ${DST}";
ln -s ${SRC} ${DST};
echo "[info] Link created ${DST} -> ${SRC}";