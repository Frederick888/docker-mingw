#!/bin/sh

set -e

apt-get -qq -y install curl vim git libssh2-1-dev libssl-dev

echo "### INSTALLING cargo-clone ###"
cargo install cargo-clone

rust_test_template() {
    echo "### TESTING $1 ###"
    cd /apps
    cargo clone "$1"
    cd "$1"
    env $2 cargo build --target x86_64-pc-windows-gnu
}

# WINAPI-BUILD
rust_test_template winapi-build

# LIBZ-SYS
rust_test_template libz-sys

# OPENSSL-SYS
#rust_test_template openssl-sys "OPENSSL_DIR=/usr/x86_64-w64-mingw32"

# LIBSSH2-SYS
rust_test_template libssh2-sys

# LIBXML
rust_test_template libxml 'CFLAGS=-I/usr/x86_64-w64-mingw32/include/libxml2 LDFLAGS=-L/usr/x86_64-w64-mingw32/lib'

# LIBGIT2
rust_test_template libgit2-sys

# CURL-SYS
rust_test_template curl-sys

