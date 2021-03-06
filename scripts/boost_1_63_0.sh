#!/bin/sh

set -e

cd /builds
curl -O -J -L https://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.gz/download
tar xf boost_1_63_0.tar.gz
cd /builds/boost_1_63_0
patch -Np0 -i /builds/patches/boost/boost-mingw.patch
cd /builds/boost_1_63_0/libs/serialization
patch -p1 -i /builds/patches/boost/42.patch
cd /builds/boost_1_63_0
cp /builds/patches/boost/user-config.jam ./
./bootstrap.sh --with-toolset=gcc --with-python=/usr/bin/python2
./b2 -d+2 -q -j$(nproc) target-os=windows variant=release threading=multi threadapi=win32 link=static \
        runtime-link=shared --prefix=/usr/x86_64-w64-mingw32 --user-config=user-config.jam --without-python \
        --without-mpi --without-graph_parallel \
        cxxflags="-std=c++11 -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions --param=ssp-buffer-size=4" \
        address-model=64 architecture=x86 binary-format=pe --layout=tagged install
