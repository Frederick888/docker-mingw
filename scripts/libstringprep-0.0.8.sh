#!/bin/sh

cd /builds
curl -O -J https://alpha.gnu.org/gnu/libidn/libstringprep-0.0.8.tar.gz
tar xf libstringprep-0.0.8.tar.gz
cd /builds/libstringprep-0.0.8
./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
make && make install
