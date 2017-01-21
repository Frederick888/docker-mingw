FROM debian:jessie

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install curl unzip autoconf build-essential pkg-config cmake mingw-w64

# ZLIB
WORKDIR /builds
RUN curl -O -J http://www.zlib.net/zlib-1.2.11.tar.gz
RUN tar xf zlib-1.2.11.tar.gz
WORKDIR /builds/zlib-1.2.11
RUN CC=x86_64-w64-mingw32-gcc ./configure --prefix=/usr/x86_64-w64-mingw32 --static
RUN make && make install

# OPENSSL
WORKDIR /builds
RUN curl -O -J https://www.openssl.org/source/openssl-1.0.2j.tar.gz
RUN tar xf openssl-1.0.2j.tar.gz
WORKDIR /builds/openssl-1.0.2j
RUN CROSS_COMPILE="x86_64-w64-mingw32-" ./Configure -DHAVE_STRUCT_TIMESPEC -lz -lws2_32 zlib mingw64 no-shared --prefix=/usr/x86_64-w64-mingw32
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
RUN LIBS="-lgdi32 -lcrypt32" ./configure --with-openssl --with-libz --prefix=/usr/x86_64-w64-mingw32 --host=x86_64-w64-mingw32
RUN make && make install
