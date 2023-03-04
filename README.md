# alpine-haskell-stack

[![Build](https://github.com/fpco/alpine-haskell-stack/actions/workflows/test.yaml/badge.svg)](https://github.com/fpco/alpine-haskell-stack/actions/workflows/test.yaml)

Docker images that are used to build static binary for Haskell projects.

The images here are used to build the static binary for the Haskell's stack build tool.

# Note on Docker image generation

- In this specific case, we are not using the official musl based ghc
  binaries supplied by `downloads.haskell.org` as it result in
  segmentation fault error when it was used to try and build the stack
  codebase.
- Instead we build musl based GHC using Musl infrastructure of
  nixpkgs.
- Note that we have to pass the appropriate `~/.stack/config.yaml`
  with proper location of include headers and library files to make
  the build working.

If you have to update the image for newer GHC, you have to update these things:

- The nixpkgs commit which has the specific GHC you want. Update the
  [ghc-musl.nix](./ghc-musl.nix) with the appropriate commit.
- Optionally, you can update the SHA of the base alpine image in the
  ghc-musl.nix file. It's optional, but good to have latest stable
  alpine image as the base image.
- Update the [justfile](./justfile) with the new GHC tag.
- Update the stack version in the [Dockerfile](./Dockerfile).

# Building images

We use [just](https://github.com/casey/just) tool to simplify the building process. To build image
do this:

``` shellsession
just build-nix-image
just load-nix-image
just build-image
```

# Testing image

``` shellsession
❯ just test-image
docker run --tty --interactive fpco/alpine-haskell-stack:9.2.7 sh
/ # ghc --version
The Glorious Glasgow Haskell Compilation System, version 9.2.7
/ # stack --version
Version 2.9.3, Git revision 6cf638947a863f49857f9cfbf72a38a48b183e7e x86_64 hpack-0.35.1
```
## Available images in DockerHub

* [GHC 9.2.7](https://registry.hub.docker.com/layers/fpco/alpine-haskell-stack/9.2.7/images/sha256-b3cf2355764e5002f0862eeb0772f448292bde174a818e55b9138181c5e8b3ad?context=explore)
* [GHC 9.2.5](https://hub.docker.com/layers/fpco/alpine-haskell-stack/9.2.5/images/sha256-dc81f5e944403f2d1d5c2e5f974b15a2f244687713beb7e4c73e9dc120a558b5?context=explore)
* [GHC 9.2.3](https://hub.docker.com/layers/alpine-haskell-stack/fpco/alpine-haskell-stack/9.2.3/images/sha256-a5e554fa11c2d565b30acda5881eeac22e5aee0fb70041614111ab70a01fd658?context=explore)
* [GHC 9.2.2](https://hub.docker.com/layers/alpine-haskell-stack/fpco/alpine-haskell-stack/9.2.2/images/sha256-edcc6e5d783d3a13cbb863cbb4bf2511b4369bb3efb24825738d1dafdd1760c6?context=explore)
* [GHC 8.10.6](https://hub.docker.com/layers/fpco/alpine-haskell-stack/8.10.6/images/sha256-51544a80444626eb8c35fc5a6d33c2ad3834a39f30bb13e6337b74d5a0d85cd0?context=explore)
* [GHC 8.10.4](https://hub.docker.com/layers/fpco/alpine-haskell-stack/8.10.4/images/sha256-ff56997dc0cd1f859a342b6c4b0f069600e21574c9371657817ce8738c8461af?context=repo)
* [GHC 8.8.3](https://hub.docker.com/layers/fpco/alpine-haskell-stack/gmp-ghc-8.8.3/images/sha256-bf1050a24b0a9d309ec98418e578ddce474dd60542da8f9367f36e4ed6498e8e?context=repo)
* [GHC 8.6.5](https://hub.docker.com/layers/fpco/alpine-haskell-stack/8.6.5/images/sha256-49e7e15f3b1d3f882ba5bb701463b1d508fbf40e5aafce6ea31acd210da570ba?context=explore)
