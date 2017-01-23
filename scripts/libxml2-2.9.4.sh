#!/bin/sh

set -e

cd /builds
curl -O -J ftp://xmlsoft.org/libxml2/libxml2-2.9.4.tar.gz
tar xf libxml2-2.9.4.tar.gz
cd /builds/libxml2-2.9.4
patch -Np0 -i /builds/patches/libxml2/mingw32-libxml2-static-build-compile-fix.patch
patch -Np1 -i /builds/patches/libxml2/libxml2-no-test.patch
sed -i "s| doc example | |g" Makefile.am
autoreconf -vfi
LIBS="-lz" LDFLAGS="-L/usr/x86_64-w64-mingw32/lib" ./configure --without-python --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
make && make install
