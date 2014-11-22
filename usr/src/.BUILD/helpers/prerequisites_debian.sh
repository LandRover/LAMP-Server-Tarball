#!/bin/bash

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
automake1.9 \
gcc \
g++;
