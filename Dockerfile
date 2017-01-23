FROM debian:jessie

RUN apt-get -qq update
RUN apt-get -qq -y dist-upgrade
RUN apt-get -qq -y install autoconf build-essential pkg-config cmake libtool mingw-w64
RUN apt-get -qq -y install curl unzip python wget

RUN mkdir /builds

#ADD scripts/libgw32c-0.4.sh /apps/scripts/libgw32c-0.4.sh
#RUN /apps/scripts/libgw32c-0.4.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

#ADD scripts/mingw-catgets-1.0.1.sh /apps/scripts/mingw-catgets-1.0.1.sh
#RUN /apps/scripts/mingw-catgets-1.0.1.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/zlib-1.2.11.sh /apps/scripts/zlib-1.2.11.sh
RUN /apps/scripts/zlib-1.2.11.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

#ADD scripts/openssl-1.1.0c.sh /apps/scripts/openssl-1.1.0c.sh
#RUN /apps/scripts/openssl-1.1.0c.sh >> /apps/build_stdout.log
ADD scripts/openssl-1.0.2j.sh /apps/scripts/openssl-1.0.2j.sh
RUN /apps/scripts/openssl-1.0.2j.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/bzip2-1.0.6.sh /apps/scripts/bzip2-1.0.6.sh
RUN /apps/scripts/bzip2-1.0.6.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/sqlite-autoconf-3160200.sh /apps/scripts/sqlite-autoconf-3160200.sh
RUN /apps/scripts/sqlite-autoconf-3160200.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libssh2-1.8.0.sh /apps/scripts/libssh2-1.8.0.sh
RUN /apps/scripts/libssh2-1.8.0.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libunistring-0.9.7.sh /apps/scripts/libunistring-0.9.7.sh
RUN /apps/scripts/libunistring-0.9.7.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libiconv-1.14.sh /apps/scripts/libiconv-1.14.sh
RUN /apps/scripts/libiconv-1.14.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libstringprep-0.0.8.sh /apps/scripts/libstringprep-0.0.8.sh
RUN /apps/scripts/libstringprep-0.0.8.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libidn-1.17.sh /apps/scripts/libidn-1.17.sh
RUN /apps/scripts/libidn-1.17.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libidn2-0.11.sh /apps/scripts/libidn2-0.11.sh
RUN /apps/scripts/libidn2-0.11.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libxml2-2.9.4.sh /apps/scripts/libxml2-2.9.4.sh
RUN /apps/scripts/libxml2-2.9.4.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/libgit2-0.25.1.sh /apps/scripts/libgit2-0.25.1.sh
RUN /apps/scripts/libgit2-0.25.1.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/boost_1_63_0.sh /apps/scripts/boost_1_63_0.sh
RUN /apps/scripts/boost_1_63_0.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds

ADD scripts/curl-7.52.1.sh /apps/scripts/curl-7.52.1.sh
RUN /apps/scripts/curl-7.52.1.sh >> /apps/build_stdout.log
RUN rm -rf /builds && mkdir /builds


# RUST STABLE (LEAVE ME AT THE END)
WORKDIR /builds
RUN curl https://sh.rustup.rs -o rust-init
RUN chmod +x rust-init
RUN ./rust-init -y --default-toolchain nightly
RUN ln -s $HOME/.cargo/bin/* /usr/local/bin/
RUN rustup target add x86_64-pc-windows-gnu

WORKDIR /apps
RUN rm -rf /builds
