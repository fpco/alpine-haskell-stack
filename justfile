GHC_VERSION := "9.2.8"
TAG_VERSION := "v1"

# List all recipies
default:
    just --list --unsorted

# Build docker image
build-image:
    docker image build . -f Dockerfile -t ghcr.io/fpco/alpine-haskell-stack:{{GHC_VERSION}}{{TAG_VERSION}}

# Push image
push-image:
    docker push ghcr.io/fpco/alpine-haskell-stack:{{GHC_VERSION}}{{TAG_VERSION}}

# Build nix image
build-nix-image:
    nix-build -v ghc-musl.nix

# Load nix image
load-nix-image:
    docker load < result

# Test image
test-image:
    docker run --rm --tty ghcr.io/fpco/alpine-haskell-stack:{{GHC_VERSION}}{{TAG_VERSION}} ghc --version
    docker run --rm --tty ghcr.io/fpco/alpine-haskell-stack:{{GHC_VERSION}}{{TAG_VERSION}} stack --version

# Build ghc based image
build-ghc-image:
	docker image build . -f ghc-Dockerfile -t ghcr.io/fpco/alpine-haskell-stack:ghc-{{GHC_VERSION}}{{TAG_VERSION}}

# Push ghc image
push-ghc-image:
    docker push ghcr.io/fpco/alpine-haskell-stack:ghc-{{GHC_VERSION}}

# Test image
test-ghc-image:
    docker run --rm --tty ghcr.io/fpco/alpine-haskell-stack:ghc-{{GHC_VERSION}}{{TAG_VERSION}} ghc --version
    docker run --rm --tty ghcr.io/fpco/alpine-haskell-stack:ghc-{{GHC_VERSION}}{{TAG_VERSION}} stack --version
