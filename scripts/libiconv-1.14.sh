#!/bin/sh

set -e

cd /builds
curl -O -J http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
tar xf libiconv-1.14.tar.gz
cd /builds/libiconv-1.14
./configure --enable-extra-encodings --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
make && make install
