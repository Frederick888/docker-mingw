#!/bin/sh

set -e

cd /builds
curl -O -J http://www.zlib.net/zlib-1.2.11.tar.gz
tar xf zlib-1.2.11.tar.gz
cd /builds/zlib-1.2.11
sed -ri "s/SHARED_MODE=0/SHARED_MODE=1/" win32/Makefile.gcc
sed -ri "s/^PREFIX =/PREFIX = x86_64-w64-mingw32-/" win32/Makefile.gcc
CFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions --param=ssp-buffer-size=4" ./configure --prefix=/usr/x86_64-w64-mingw32 -shared -static
CFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions --param=ssp-buffer-size=4" make -f win32/Makefile.gcc
INCLUDE_PATH=/usr/x86_64-w64-mingw32/include LIBRARY_PATH=/usr/x86_64-w64-mingw32/lib BINARY_PATH=/usr/x86_64-w64-mingw32/bin make install -f win32/Makefile.gcc
