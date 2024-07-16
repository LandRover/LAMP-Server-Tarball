#!/bin/bash

REPO_URL="git@github.com:LandRover/LAMP-Server-Tarball.git";
LOCAL_DIR="/LAMP-Server-Tarball";

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "[INFO] Git is not installed. Installing...";
    sudo apt-get update;
    sudo apt-get install -y git;
fi

# Check if the repository directory exists
if [ ! -d "${LOCAL_DIR}" ]; then
    # Clone the repository if it doesn't exist
    echo "[INFO] Cloning repository ${REPO_URL} to ${LOCAL_DIR}";
    sudo git clone "${REPO_URL}" "${LOCAL_DIR}";
else
    # Pull updates if the repository already exists
    echo "[INFO] Repository already exists. Updating...";
    cd "${LOCAL_DIR}";
    sudo git pull
fi

${LOCAL_DIR}/usr/src/.BUILD/helpers/initialize.sh;
