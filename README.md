# alpine-haskell-stack

Docker images that are used to build static binary for Haskell
projects.

The images here are used to build the static binary for the Haskell's
stack build tool.

# Note on Docker image generation

- In this specific case, we are not using the official musl based ghc
  binaries supplied by `downloads.haskell.org` as it seems to result
  in segmentation fault error when it was used to try and build the
  stack codebase.
- Instead we build musl based GHC using Musl infrastructure of
  nixpkgs.
- Note that we have to pass the appropriate `~/.stack/config.yaml`
  with proper location of include headers and library files to make
  the build working.

## Available images in DockerHub

* [GHC 9.2.5](https://hub.docker.com/layers/fpco/alpine-haskell-stack/9.2.5/images/sha256-dc81f5e944403f2d1d5c2e5f974b15a2f244687713beb7e4c73e9dc120a558b5?context=explore)
* [GHC 9.2.3](https://hub.docker.com/layers/alpine-haskell-stack/fpco/alpine-haskell-stack/9.2.3/images/sha256-a5e554fa11c2d565b30acda5881eeac22e5aee0fb70041614111ab70a01fd658?context=explore)
* [GHC 9.2.2](https://hub.docker.com/layers/alpine-haskell-stack/fpco/alpine-haskell-stack/9.2.2/images/sha256-edcc6e5d783d3a13cbb863cbb4bf2511b4369bb3efb24825738d1dafdd1760c6?context=explore)
* [GHC 8.10.6](https://hub.docker.com/layers/fpco/alpine-haskell-stack/8.10.6/images/sha256-51544a80444626eb8c35fc5a6d33c2ad3834a39f30bb13e6337b74d5a0d85cd0?context=explore)
* [GHC 8.10.4](https://hub.docker.com/layers/fpco/alpine-haskell-stack/8.10.4/images/sha256-ff56997dc0cd1f859a342b6c4b0f069600e21574c9371657817ce8738c8461af?context=repo)
* [GHC 8.8.3](https://hub.docker.com/layers/fpco/alpine-haskell-stack/gmp-ghc-8.8.3/images/sha256-bf1050a24b0a9d309ec98418e578ddce474dd60542da8f9367f36e4ed6498e8e?context=repo)
* [GHC 8.6.5](https://hub.docker.com/layers/fpco/alpine-haskell-stack/8.6.5/images/sha256-49e7e15f3b1d3f882ba5bb701463b1d508fbf40e5aafce6ea31acd210da570ba?context=explore)
