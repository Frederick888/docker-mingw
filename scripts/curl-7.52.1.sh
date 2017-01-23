#!/bin/sh

# to be improved
cd /builds
curl -O -J https://curl.haxx.se/download/curl-7.52.1.tar.gz
tar xf curl-7.52.1.tar.gz
cd /builds/curl-7.52.1
./configure --prefix=/usr/x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --enable-optimize \
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
make && make install
