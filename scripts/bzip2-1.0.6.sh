#!/bin/sh

set -e

cd /builds
curl -O -J http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
tar xf bzip2-1.0.6.tar.gz
cd /builds/bzip2-1.0.6
rm -f autogen.sh README.autotools configure.ac Makefile.am bzip2.pc.in
patch -p1 -i /builds/patches/bzip2/bzip2-1.0.5-autoconfiscated.patch
patch bzlib.h < /builds/patches/bzip2/bzip2-use-cdecl-calling-convention.patch
patch bzip2.c < /builds/patches/bzip2/mingw32-bzip2-1.0.5-slash.patch
sh autogen.sh
./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
make -j$(nproc) && make install
