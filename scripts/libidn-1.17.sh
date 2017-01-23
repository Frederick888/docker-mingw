#!/bin/sh

cd /builds
curl -O -J https://alpha.gnu.org/gnu/libidn/libidn-1.17.tar.gz
tar xf libidn-1.17.tar.gz
cd /builds/libidn-1.17
./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
make && make install
