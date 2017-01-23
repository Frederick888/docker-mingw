#!/bin/sh

cd /builds
curl -O -J https://sqlite.org/2017/sqlite-autoconf-3160200.tar.gz
tar xf sqlite-autoconf-3160200.tar.gz
cd /builds/sqlite-autoconf-3160200
./configure --prefix=/usr/x86_64-w64-mingw32 --host=x86_64-w64-mingw32
make && make install
