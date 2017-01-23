#!/bin/sh

set -e

# 0.11 is the latest compilable version
cd /builds
curl -O -J https://alpha.gnu.org/gnu/libidn/libidn2-0.11.tar.gz
tar xf libidn2-0.11.tar.gz
cd /builds/libidn2-0.11
./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
make -j$(nproc) && make install
