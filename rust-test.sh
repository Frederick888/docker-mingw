#!/bin/sh

set -e

apt-get -y install curl vim git libssh2-1-dev libssl-dev

apt-get -y install apt-transport-https ca-certificates software-properties-common
curl -fsSL https://yum.dockerproject.org/gpg | apt-key add -
add-apt-repository -y "deb https://apt.dockerproject.org/repo/ debian-$(lsb_release -cs) main"
apt-get update
apt-get -y install docker-engine

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

