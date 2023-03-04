FROM psibi/alpine-haskell-stack:v3

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
        binutils \
        build-base \
        coreutils \
        cpio \
        linux-headers \
        libffi-dev \
        musl-dev \
        zlib-dev \
        zlib-static \
        ncurses-dev \
        ncurses-libs \
        ncurses-static \
        bash \
        lld \
        shadow # for stack --docker, provides groupadd

RUN curl -sSLo /usr/local/bin/stack https://github.com/commercialhaskell/stack/releases/download/v2.9.3/stack-2.9.3-linux-x86_64-bin && \
    chmod +x /usr/local/bin/stack

# https://stackoverflow.com/a/41517423
RUN ln -s /usr/lib/libncurses.a /usr/lib/libtinfo.a

COPY stack-config.yaml /root/.stack/config.yaml
