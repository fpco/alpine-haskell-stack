GHC_VERSION := "9.2.7"

# List all recipies
default:
    just --list --unsorted

# Build docker image
build-image:
    docker image build . -f Dockerfile -t fpco/alpine-haskell-stack:{{GHC_VERSION}}

# Push image
push-image:
    docker push fpco/alpine-haskell-stack:{{GHC_VERSION}}

# Build nix image
build-nix-image:
    nix-build -v ghc-musl.nix

# Load nix image
load-nix-image:
    docker load < result

# Test image
test-image:
    docker run --tty --interactive fpco/alpine-haskell-stack:{{GHC_VERSION}} sh
