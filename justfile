GHC_VERSION := `git describe --abbrev=0`

# List all recipies
default:
    just --list --unsorted

# Build docker image
build-image:
    docker image build . -f Dockerfile -t ghcr.io/fpco/alpine-haskell-stack:{{GHC_VERSION}}

# Push image
push-image:
    docker push ghcr.io/fpco/alpine-haskell-stack:{{GHC_VERSION}}

# Build nix image
build-nix-image:
    nix-build -v ghc-musl.nix

# Load nix image
load-nix-image:
    docker load < result

# Test image
test-image:
    docker run --rm --tty ghcr.io/fpco/alpine-haskell-stack:{{GHC_VERSION}} ghc --version
    docker run --rm --tty ghcr.io/fpco/alpine-haskell-stack:{{GHC_VERSION}} stack --version
