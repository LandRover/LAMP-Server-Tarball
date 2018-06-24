#!/bin/bash

update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1;
update-alternatives --install /usr/bin/python python /usr/bin/python3.4 2;
update-alternatives --config python;
