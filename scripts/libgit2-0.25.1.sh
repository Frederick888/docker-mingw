#!/bin/sh

set -e

cd /builds
curl -O -J -L https://github.com/libgit2/libgit2/archive/v0.25.1.tar.gz
tar xf libgit2-0.25.1.tar.gz
mkdir -p /builds/libgit2-0.25.1/build
cd /builds/libgit2-0.25.1/build
cmake .. -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc -DCMAKE_RC_COMPILER=x86_64-w64-mingw32-windres \
        -DCMAKE_FIND_ROOT_PATH=/usr/x86_64-w64-mingw32 -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY -DDLLTOOL=/usr/bin/x86_64-w64-mingw32-dlltool -DCMAKE_INSTALL_PREFIX=/usr/x86_64-w64-mingw32
make -j$(nproc) && make install
