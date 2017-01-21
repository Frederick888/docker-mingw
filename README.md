# Introduction

Debian with MinGW and some pre-compiled common (static) libraries and toolchains.

This Docker image mainly aims to provide pre-compiled binaries for Rust FFI bindings.

Docker Hub: https://hub.docker.com/r/frederickzh/mingw/

# Branches/Tags

## rust-nightly

*SEND PR TO THIS BRANCH!!!*

Binaries and Rust nightly toolchain installed by [rustup](https://www.rustup.rs/).

There is also a `rust-test.sh` script in this branch for CI testing.

## rust-stable

Same as rust-nightly, but with Rust stable toolchain.
