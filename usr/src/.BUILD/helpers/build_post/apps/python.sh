#!/bin/bash

## prints compilation args
${BIN_DIR}/${APP_NAME}/bin/${APP_NAME} -c "import sysconfig; print(sysconfig.get_config_vars('CONFIG_ARGS'));"
