FROM debian:jessie

RUN apt-get -qq update
RUN apt-get -qq -y dist-upgrade
RUN apt-get -qq -y install autoconf build-essential pkg-config cmake libtool mingw-w64
RUN apt-get -qq -y install curl unzip python wget

ADD . /apps

# LIBGW32C
#WORKDIR /builds
#RUN curl -O -L -J http://gnuwin32.sourceforge.net/downlinks/libgw32c-src-zip.php
#RUN unzip $(ls libgw32c*.zip) -d libgw32c
#WORKDIR /builds/libgw32c/src/libgw32c/0.4/libgw32c-0.4

# MINGW-CATGETS
#WORKDIR /builds
#RUN curl -O -L -J https://sourceforge.net/projects/mingw/files/MinGW/Extension/catgets/mingw-catgets-1.0.1/mingw-catgets-1.0.1-src.tar.gz/download
#RUN tar xf mingw-catgets-1.0.1-src.tar.gz
#WORKDIR /builds/mingw-catgets-1.0.1
#RUN patch catopen.c /apps/patches/mingw-catgets-catopen-20170123.diff
#RUN ./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
#RUN make && make install

# ZLIB
WORKDIR /builds
RUN curl -O -J http://www.zlib.net/zlib-1.2.11.tar.gz
RUN tar xf zlib-1.2.11.tar.gz
WORKDIR /builds/zlib-1.2.11
RUN sed -ri "s/SHARED_MODE=0/SHARED_MODE=1/" win32/Makefile.gcc
RUN sed -ri "s/^PREFIX =/PREFIX = x86_64-w64-mingw32-/" win32/Makefile.gcc
RUN CFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions --param=ssp-buffer-size=4" ./configure --prefix=/usr/x86_64-w64-mingw32 -shared -static
RUN CFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions --param=ssp-buffer-size=4" make -f win32/Makefile.gcc
RUN INCLUDE_PATH=/usr/x86_64-w64-mingw32/include LIBRARY_PATH=/usr/x86_64-w64-mingw32/lib BINARY_PATH=/usr/x86_64-w64-mingw32/bin make install -f win32/Makefile.gcc

# OPENSSL
WORKDIR /builds
#RUN curl -O -J https://www.openssl.org/source/openssl-1.1.0c.tar.gz
#RUN tar xf openssl-1.1.0c.tar.gz
#WORKDIR /builds/openssl-1.1.0c
RUN curl -O -J https://www.openssl.org/source/openssl-1.0.2j.tar.gz
RUN tar xf openssl-1.0.2j.tar.gz
WORKDIR /builds/openssl-1.0.2j
RUN CROSS_COMPILE="x86_64-w64-mingw32-" ./Configure -DHAVE_STRUCT_TIMESPEC -lz -lws2_32 zlib threads shared no-asm mingw64 --prefix=/usr/x86_64-w64-mingw32
RUN make depend
RUN make && make install

# BZIP2
WORKDIR /builds
RUN curl -O -J http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
RUN tar xf bzip2-1.0.6.tar.gz
WORKDIR /builds/bzip2-1.0.6
RUN rm -f autogen.sh README.autotools configure.ac Makefile.am bzip2.pc.in
RUN patch -p1 -i "$srcdir/"bzip2-1.0.5-autoconfiscated.patch
RUN patch bzlib.h < "$srcdir/"bzip2-use-cdecl-calling-convention.patch
RUN patch bzip2.c < "$srcdir/"mingw32-bzip2-1.0.5-slash.patch
RUN sh autogen.sh
RUN ./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
RUN make && make install

# SQLITE3
WORKDIR /builds
RUN curl -O -J https://sqlite.org/2017/sqlite-autoconf-3160200.tar.gz
RUN tar xf sqlite-autoconf-3160200.tar.gz
WORKDIR /builds/sqlite-autoconf-3160200
RUN ./configure --prefix=/usr/x86_64-w64-mingw32 --host=x86_64-w64-mingw32
RUN make && make install

# LIBSSH2
WORKDIR /builds
RUN curl -O -J https://www.libssh2.org/download/libssh2-1.8.0.tar.gz
RUN tar xf libssh2-1.8.0.tar.gz
WORKDIR /builds/libssh2-1.8.0
RUN LIBS="-lgdi32 -lcrypt32" ./configure --with-openssl --with-libz --prefix=/usr/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --enable-shared --enable-static
RUN make && make install

# LIBUNISTRING
WORKDIR /builds
RUN curl -O -J http://ftp.gnu.org/gnu/libunistring/libunistring-0.9.7.tar.xz
RUN tar xf libunistring-0.9.7.tar.xz
WORKDIR /builds/libunistring-0.9.7
RUN ./configure --enable-threads=windows --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
RUN make && make install

# LIBICONV
WORKDIR /builds
RUN curl -O -J http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
RUN tar xf libiconv-1.14.tar.gz
WORKDIR /builds/libiconv-1.14
RUN ./configure --enable-extra-encodings --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
RUN make && make install

# LIBSTRINGGREP
WORKDIR /builds
RUN curl -O -J https://alpha.gnu.org/gnu/libidn/libstringprep-0.0.8.tar.gz
RUN tar xf libstringprep-0.0.8.tar.gz
WORKDIR /builds/libstringprep-0.0.8
RUN ./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
RUN make && make install

# LIBIDN
WORKDIR /builds
RUN curl -O -J https://alpha.gnu.org/gnu/libidn/libidn-1.17.tar.gz
RUN tar xf libidn-1.17.tar.gz
WORKDIR /builds/libidn-1.17
RUN ./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
RUN make && make install

# LIBIDN2
# 0.11 is the latest compilable version
WORKDIR /builds
RUN curl -O -J https://alpha.gnu.org/gnu/libidn/libidn2-0.11.tar.gz
RUN tar xf libidn2-0.11.tar.gz
WORKDIR /builds/libidn2-0.11
RUN ./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
RUN make && make install

# LIBPSL
#WORKDIR /builds
#RUN curl -O -L -J curl -O -L -J https://github.com/rockdaboot/libpsl/releases/download/libpsl-0.17.0/libpsl-0.17.0.tar.gz
#RUN tar xf libpsl-0.17.0.tar.gz
#WORKDIR /builds/libpsl-0.17.0

# LIBXML2
WORKDIR /builds
RUN curl -O -J ftp://xmlsoft.org/libxml2/libxml2-2.9.4.tar.gz
RUN tar xf libxml2-2.9.4.tar.gz
WORKDIR /builds/libxml2-2.9.4
RUN patch -Np0 -i /apps/patches/libxml2/mingw32-libxml2-static-build-compile-fix.patch
RUN patch -Np1 -i /apps/patches/libxml2/libxml2-no-test.patch
RUN sed -i "s| doc example | |g" Makefile.am
RUN autoreconf -vfi
RUN LIBS="-lz" LDFLAGS="-L/usr/x86_64-w64-mingw32/lib" ./configure --without-python --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32
RUN make && make install

# LIBGIT2
WORKDIR /builds
RUN curl -O -J -L https://github.com/libgit2/libgit2/archive/v0.25.1.tar.gz
RUN tar xf libgit2-0.25.1.tar.gz
RUN mkdir -p /builds/libgit2-0.25.1/build
WORKDIR /builds/libgit2-0.25.1/build
RUN cmake .. -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc -DCMAKE_RC_COMPILER=x86_64-w64-mingw32-windres \
        -DCMAKE_FIND_ROOT_PATH=/usr/x86_64-w64-mingw32 -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY -DDLLTOOL=/usr/bin/x86_64-w64-mingw32-dlltool -DCMAKE_INSTALL_PREFIX=/usr/x86_64-w64-mingw32
RUN make && make install

# BOOST
WORKDIR /builds
RUN curl -O -J -L https://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.gz/download
RUN tar xf boost_1_63_0.tar.gz
WORKDIR /builds/boost_1_63_0
RUN patch -Np0 -i /apps/patches/boost/boost-mingw.patch
WORKDIR /builds/boost_1_63_0/libs/serialization
RUN patch -p1 -i /apps/patches/boost/42.patch
WORKDIR /builds/boost_1_63_0
RUN cp /apps/patches/boost/user-config.jam ./
RUN ./bootstrap.sh --with-toolset=gcc --with-python=/usr/bin/python2
RUN ./b2 -d+2 -q target-os=windows variant=release threading=multi threadapi=win32 link=static \
        runtime-link=shared --prefix=/usr/x86_64-w64-mingw32 --user-config=user-config.jam --without-python \
        --without-mpi --without-graph_parallel \
        cxxflags="-std=c++11 -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions --param=ssp-buffer-size=4" \
        address-model=64 architecture=x86 binary-format=pe --layout=tagged install

# CURL
# to be improved
WORKDIR /builds
RUN curl -O -J https://curl.haxx.se/download/curl-7.52.1.tar.gz
RUN tar xf curl-7.52.1.tar.gz
WORKDIR /builds/curl-7.52.1
RUN ./configure --prefix=/usr/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --enable-optimize \
        --with-ssl=/usr/x86_64-w64-mingw32 \
        --with-gssapi \
        --enable-tls-srp \
        --with-winidn \
        --with-nghttp2 \
        --with-libmetalink \
        --enable-http \
        --enable-ftp \
        --enable-file \
        --enable-ldap \
        --enable-ldaps \
        --enable-rtsp \
        --enable-proxy \
        --enable-dict \
        --enable-telnet \
        --enable-tftp \
        --enable-pop3 \
        --enable-imap \
        --enable-smb \
        --enable-smtp \
        --enable-gopher \
        --enable-manual \
        --enable-ipv6 \
        --enable-sspi \
        --enable-cookies
RUN make && make install


# RUST NIGHTLY (LEAVE ME AT THE END)
WORKDIR /builds
RUN curl https://sh.rustup.rs -o rust-init
RUN chmod +x rust-init
RUN ./rust-init -y --default-toolchain nightly
RUN ln -s $HOME/.cargo/bin/* /usr/local/bin/
RUN rustup target add x86_64-pc-windows-gnu
