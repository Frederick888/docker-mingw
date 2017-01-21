FROM debian:jessie

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install curl unzip autoconf build-essential pkg-config mingw-w64

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

# RUST STABLE
WORKDIR /builds
RUN curl https://sh.rustup.rs -o rust-init
RUN chmod +x rust-init
RUN ./rust-init -y
RUN ln -s $HOME/.cargo/bin/* /usr/local/bin/
RUN rustup target add x86_64-pc-windows-gnu

