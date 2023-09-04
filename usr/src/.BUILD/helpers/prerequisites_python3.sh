#!/bin/bash

apt-get -y install \
python3-pip \
python3-setuptools \
python3-dev \
build-essential;

pip3 install --upgrade virtualenv;

update-alternatives --install /usr/bin/python python /opt/local/sbin/python/bin/python3.11 1;
update-alternatives --install /usr/bin/python python /usr/bin/python3.9 2;
update-alternatives --config python;
