#!/bin/bash

CPWD="`dirname ${BASH_SOURCE}`";
ROOT_PATH=`realpath ${CPWD}/../../../../`;
ETC_SOURCE_DIR="${ROOT_PATH}/opt/local/etc"
ETC_DEST_DIR="/opt/local/etc"
echo $ROOT_PATH
echo "[INFO] Verifiying ${ETC_DEST_DIR} etc folder";

# Check if DEST_DIR doesn't exist
if [ ! -d "${ETC_DEST_DIR}" ]; then
    echo "Creating ${ETC_DEST_DIR} directory..."
    mkdir -p "${ETC_DEST_DIR}"

    # Check if the directory was successfully created
    if [ $? -ne 0 ]; then
        echo "Failed to create ${ETC_DEST_DIR}. Exiting."
        exit 1
    fi

    # Copy all files from SOURCE_DIR to DEST_DIR
    echo "Copying files from ${ETC_SOURCE_DIR} to ${ETC_DEST_DIR}..."
    cp -r "${ETC_SOURCE_DIR}/"* "${ETC_DEST_DIR}/"
    
    # Check if the copy operation was successful
    if [ $? -ne 0 ]; then
        echo "Failed to copy files to ${DEST_DIR}. Exiting."
        exit 1
    fi
    
    echo "Files copied successfully to ${DEST_DIR}."
else
    echo "${ETC_DEST_DIR} already exists. Skipping creation and copy."
fi


# Check if Debian is the current operating system
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [ "${ID}" = "debian" ]; then
        echo "[INFO] Install debian dependencies";
        ./prerequisites_debian.sh;
    else
        echo "Current operating system is not Debian."
    fi
else
    echo "Unable to determine current operating system."
fi

${CPWD}/bin/ln.sh ${ROOT_PATH}/usr/src /usr/src;

echo "[INFO] initialize completed";


