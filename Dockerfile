################################################################################
# Set up environment variables, OS packages, and scripts that are common to the
# build and distribution layers in this Dockerfile
FROM alpine:3.11 AS base

# Must be a valid GHC version number, only tested with 8.4.4, 8.6.4, and 8.6.5
#
ARG GHC_VERSION=8.6.5-r3

# Install the basic required dependencies to run 'ghcup' and 'stack'
RUN apk upgrade --no-cache && \
    apk update && \
    apk add --no-cache \
        curl \
        gcc \
        git \
        libc-dev \
        xz \
        ghc-dev=$GHC_VERSION

################################################################################
# Intermediate layer that assembles 'stack' tooling
FROM base AS build-tooling

ENV STACK_VERSION=2.1.3
ENV STACK_SHA256="4e937a6ad7b5e352c5bd03aef29a753e9c4ca7e8ccc22deb5cd54019a8cf130c  stack-${STACK_VERSION}-linux-x86_64-static.tar.gz"

# Download, verify, and install stack
RUN echo "Downloading and installing stack" &&\
    cd /tmp &&\
    wget -P /tmp/ "https://github.com/commercialhaskell/stack/releases/download/v${STACK_VERSION}/stack-${STACK_VERSION}-linux-x86_64-static.tar.gz" &&\
    if ! echo -n "${STACK_SHA256}" | sha256sum -c -; then \
        echo "stack-${STACK_VERSION} checksum failed" >&2 &&\
        exit 1 ;\
    fi ;\
    tar -xvzf /tmp/stack-${STACK_VERSION}-linux-x86_64-static.tar.gz &&\
    cp -L /tmp/stack-${STACK_VERSION}-linux-x86_64-static/stack /usr/bin/stack &&\
    rm /tmp/stack-${STACK_VERSION}-linux-x86_64-static.tar.gz &&\
    rm -rf /tmp/stack-${STACK_VERSION}-linux-x86_64-static

################################################################################
# Assemble the final image
FROM base

COPY --from=build-tooling /usr/bin/stack /usr/bin/stack

# Install project specific dependencies
RUN apk add --no-cache \
        # required for digest -> zlib
        zlib-dev \
        # Used for Git repos by Stack
        tar \
        # NOTE: 'stack --docker' needs bash + usermod/groupmod (from shadow)
        bash shadow

RUN stack config set system-ghc --global true
