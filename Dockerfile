FROM alpine:3.13.5

RUN apk upgrade --no-cache &&\
    apk add --no-cache \
        curl \
        gcc \
        git \
        libc-dev \
        xz \
        gmp-dev \
        autoconf \
        automake \
        binutils-gold \
        build-base \
        coreutils \
        cpio \
        linux-headers \
        libffi-dev \
        musl-dev \
        ncurses-dev \
        zlib-dev

RUN curl -sSLo /usr/local/bin/stack https://github.com/commercialhaskell/stack/releases/download/v2.5.1/stack-2.5.1-linux-x86_64-bin && \
    chmod +x /usr/local/bin/stack

RUN cd /tmp && \
    curl -sSLo /tmp/ghc.tar.xz https://downloads.haskell.org/~ghc/8.10.4/ghc-8.10.4-x86_64-alpine3.10-linux-integer-simple.tar.xz && \
    tar xf ghc.tar.xz && \
    cd ghc-8.10.4-x86_64-unknown-linux && \
    ./configure --prefix=/usr/local && \
    make install && \
    rm -rf /tmp/ghc.tar.xz /tmp/ghc-8.10.4-x86_64-unknown-linux
