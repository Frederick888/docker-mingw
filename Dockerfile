FROM debian:jessie

RUN apt-get -qq update
RUN apt-get -qq -y dist-upgrade
RUN apt-get -qq -y install autoconf build-essential pkg-config cmake libtool mingw-w64
RUN apt-get -qq -y install curl unzip python wget

RUN mkdir /builds
RUN mkdir /apps

#ADD scripts/libgw32c-0.4.sh /builds/scripts/libgw32c-0.4.sh
#RUN /builds/scripts/libgw32c-0.4.sh >> /apps/build_stdout.log
#RUN rm -rf /builds && mkdir /builds

#ADD patches/mingw-catgets-catopen-20170123.diff /builds/patches/mingw-catgets-catopen-20170123.diff
#ADD scripts/mingw-catgets-1.0.1.sh /builds/scripts/mingw-catgets-1.0.1.sh
#RUN /builds/scripts/mingw-catgets-1.0.1.sh >> /apps/build_stdout.log
#RUN rm -rf /builds && mkdir /builds

ADD scripts/zlib-1.2.11.sh /builds/scripts/zlib-1.2.11.sh
RUN /builds/scripts/zlib-1.2.11.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

#ADD scripts/openssl-1.1.0c.sh /builds/scripts/openssl-1.1.0c.sh
#RUN /builds/scripts/openssl-1.1.0c.sh >> /apps/build_stdout.log
ADD scripts/openssl-1.0.2j.sh /builds/scripts/openssl-1.0.2j.sh
RUN /builds/scripts/openssl-1.0.2j.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD patches/bzip2 /builds/patches/bzip2
ADD scripts/bzip2-1.0.6.sh /builds/scripts/bzip2-1.0.6.sh
RUN /builds/scripts/bzip2-1.0.6.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/sqlite-autoconf-3160200.sh /builds/scripts/sqlite-autoconf-3160200.sh
RUN /builds/scripts/sqlite-autoconf-3160200.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libssh2-1.8.0.sh /builds/scripts/libssh2-1.8.0.sh
RUN /builds/scripts/libssh2-1.8.0.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libunistring-0.9.7.sh /builds/scripts/libunistring-0.9.7.sh
RUN /builds/scripts/libunistring-0.9.7.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libiconv-1.14.sh /builds/scripts/libiconv-1.14.sh
RUN /builds/scripts/libiconv-1.14.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libstringprep-0.0.8.sh /builds/scripts/libstringprep-0.0.8.sh
RUN /builds/scripts/libstringprep-0.0.8.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libidn-1.17.sh /builds/scripts/libidn-1.17.sh
RUN /builds/scripts/libidn-1.17.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libidn2-0.11.sh /builds/scripts/libidn2-0.11.sh
RUN /builds/scripts/libidn2-0.11.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD patches/libxml2 /builds/patches/libxml2
ADD scripts/libxml2-2.9.4.sh /builds/scripts/libxml2-2.9.4.sh
RUN /builds/scripts/libxml2-2.9.4.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libgit2-0.25.1.sh /builds/scripts/libgit2-0.25.1.sh
RUN /builds/scripts/libgit2-0.25.1.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD patches/boost /builds/patches/boost
ADD scripts/boost_1_63_0.sh /builds/scripts/boost_1_63_0.sh
RUN /builds/scripts/boost_1_63_0.sh # >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/curl-7.52.1.sh /builds/scripts/curl-7.52.1.sh
RUN /builds/scripts/curl-7.52.1.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds


# RUST NIGHTLY (LEAVE ME AT THE END)
WORKDIR /builds
RUN curl https://sh.rustup.rs -o rust-init
RUN chmod +x rust-init
RUN ./rust-init -y --default-toolchain nightly
RUN ln -s $HOME/.cargo/bin/* /usr/local/bin/
RUN rustup target add x86_64-pc-windows-gnu

WORKDIR /apps
RUN rm -rf /builds

ADD rust-test.sh /apps/rust-test.sh
