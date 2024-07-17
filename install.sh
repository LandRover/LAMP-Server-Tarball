#!/bin/bash

REPO_URL="https://github.com/LandRover/LAMP-Server-Tarball.git";
LOCAL_DIR="/LAMP-Server-Tarball";
INIT_FILE="${LOCAL_DIR}/usr/src/.BUILD/helpers/initialize.sh";

RED='\033[0;31m'
NC='\033[0m' # No Color

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

if [ -f "${INIT_FILE}" ]; then
  /bin/bash "${INIT_FILE}";
else
  echo -e "[${RED}ERROR${NC}]  Init file doesn't exist (${INIT_FILE}), Please make sure git checkout was successful from repo: ${REPO_URL} and try again."
fi
