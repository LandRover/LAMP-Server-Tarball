#!/bin/bash

ulimit -c unlimited;

## Tested and deployed on Debian wheezy 64bit
apt-get update;
apt-get upgrade;

apt-get -y install \
mc \
screen \
htop \
python-dev \
build-essential \
pkg-config \
logrotate \
libncurses5-dev \
cmake \
make \
autoconf \
automake \
gcc \
g++;
