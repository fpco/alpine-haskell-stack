# alpine-haskell-stack

Code mostly taken and updated from Joe Kachmar's
[alpine-haskell-stack](https://github.com/jkachmar/alpine-haskell-stack). This
source code is to keep track of corresponding docker public images in
[dockerhub](https://hub.docker.com/r/fpco/alpine-haskell-stack).

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

## Available images in DockerHub

* [GHC 8.10.6](https://hub.docker.com/layers/fpco/alpine-haskell-stack/8.10.6/images/sha256-51544a80444626eb8c35fc5a6d33c2ad3834a39f30bb13e6337b74d5a0d85cd0?context=explore)
* [GHC 8.10.4](https://hub.docker.com/layers/fpco/alpine-haskell-stack/8.10.4/images/sha256-ff56997dc0cd1f859a342b6c4b0f069600e21574c9371657817ce8738c8461af?context=repo)
* [GHC 8.8.3](https://hub.docker.com/layers/fpco/alpine-haskell-stack/gmp-ghc-8.8.3/images/sha256-bf1050a24b0a9d309ec98418e578ddce474dd60542da8f9367f36e4ed6498e8e?context=repo)
* [GHC 8.6.5](https://hub.docker.com/layers/fpco/alpine-haskell-stack/8.6.5/images/sha256-49e7e15f3b1d3f882ba5bb701463b1d508fbf40e5aafce6ea31acd210da570ba?context=explore)
