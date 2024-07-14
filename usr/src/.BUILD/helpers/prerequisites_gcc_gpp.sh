#!/bin/bash

apt-get -y install \
gcc-7 \
g++-7 \
gcc-8 \
g++-8;

update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 7;
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 7;
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8;
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8;

# select default gcc
update-alternatives --config gcc;

# select default g++
update-alternatives --config gcc;

# display versions
gcc --version
g++ --version
