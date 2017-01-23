#!/bin/sh

cd /builds
curl -O -J http://ftp.gnu.org/gnu/libunistring/libunistring-0.9.7.tar.xz
tar xf libunistring-0.9.7.tar.xz
cd /builds/libunistring-0.9.7
./configure --enable-threads=windows --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
make && make install
