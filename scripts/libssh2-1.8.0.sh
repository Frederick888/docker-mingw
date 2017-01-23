#!/bin/sh

set -e

cd /builds
curl -O -J https://www.libssh2.org/download/libssh2-1.8.0.tar.gz
tar xf libssh2-1.8.0.tar.gz
cd /builds/libssh2-1.8.0
LIBS="-lgdi32 -lcrypt32" ./configure --with-openssl --with-libz --prefix=/usr/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --enable-shared --enable-static
make && make install
