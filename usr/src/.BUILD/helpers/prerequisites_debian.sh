#!/bin/bash

ulimit -c unlimited;

## Tested and deployed on Debian wheezy 64bit
apt-get update;
apt-get upgrade;

apt-get -y install \
net-tools \
mc \
vim \
psmisc \
apg \
screen \
figlet \
htop \
rcconf \
gtk-doc-tools \
build-essential \
pkg-config \
logrotate \
libncurses5-dev \
rsyslog \
make \
gtk-doc-tools \
autoconf \
automake \
libtool \
intltool \
texinfo \
m4 \
gcc \
g++;
