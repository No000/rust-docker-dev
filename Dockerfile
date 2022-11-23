FROM ubuntu:22.04

# ENV PATH="/root/.cargo/bin:$PATH"
ENV PATH $PATH:/root/.cargo/bin \

RUN apt-get update

# Get Ubuntu packages
RUN apt-get install -y \
    build-essential \
    curl

# Update new packages
RUN apt-get update

# Get Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

RUN export PATH="/root/.cargo/bin:$PATH"

RUN cargo install cargo-edit
RUN rustup component add rust-analyzer
RUN rustup component add rust-src

RUN ["ln", "-sf", "/root/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer", "/root/.cargo/bin/rust-analyzer"]

WORKDIR /workspace

