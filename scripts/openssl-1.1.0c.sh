#!/bin/sh

set -e

cd /builds
curl -O -J https://www.openssl.org/source/openssl-1.1.0c.tar.gz
tar xf openssl-1.1.0c.tar.gz
cd /builds/openssl-1.1.0c
CROSS_COMPILE="x86_64-w64-mingw32-" ./Configure -DHAVE_STRUCT_TIMESPEC -lz -lws2_32 zlib threads shared no-asm mingw64 --prefix=/usr/x86_64-w64-mingw32
make depend
make -j$(nproc) && make install
