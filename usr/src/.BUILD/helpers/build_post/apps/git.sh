#!/bin/bash

# cleanup pre-installed app
apt-get remove -y ${APP_NAME};
apt-get autoremove;
