FROM ubuntu:22.04

# ENV PATH="/root/.cargo/bin:$PATH"
ENV PATH="/root/.cargo/bin:$PATH"


RUN apt-get update -y && apt-get install -y \
    build-essential \
    libssl-dev \
    pkg-config \
    curl


# Get Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

RUN export PATH="/root/.cargo/bin:$PATH" \
    export PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig"

run rustup component add rust-analyzer rust-src
# RUN rustup component add rust-src

RUN cargo install cargo-edit

RUN ["ln", "-sf", "/root/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer", "/root/.cargo/bin/rust-analyzer"]

WORKDIR /workspace

