#!/bin/bash

## prints compilation args
${BIN_DIR}/${APP_NAME}/bin/${APP_NAME}3 -c "import sysconfig; print(sysconfig.get_config_vars('CONFIG_ARGS'));"

# set primary
update-alternatives --install /usr/bin/python python ${BIN_DIR}/${APP_NAME}/bin/python3 1;
update-alternatives --install /usr/bin/pip pip ${BIN_DIR}/${APP_NAME}/bin/pip3 1;
update-alternatives --install /usr/bin/pip3 pip3 ${BIN_DIR}/${APP_NAME}/bin/pip3 1;
