#!/bin/sh
set -x
/usr/local/bin/sphinx-build -b html ${WORKSPACE}/sphinx/source ${WORKSPACE}/sphinx/build

