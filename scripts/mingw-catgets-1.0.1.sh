#!/bin/sh

cd /builds
curl -O -L -J https://sourceforge.net/projects/mingw/files/MinGW/Extension/catgets/mingw-catgets-1.0.1/mingw-catgets-1.0.1-src.tar.gz/download
tar xf mingw-catgets-1.0.1-src.tar.gz
cd /builds/mingw-catgets-1.0.1
patch catopen.c /apps/patches/mingw-catgets-catopen-20170123.diff
./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
make && make install
