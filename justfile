# List all recipies
default:
    just --list --unsorted

# Build docker image
build-image:
    docker image build . -f Dockerfile -t fpco/alpine-haskell-stack:9.2.5

# Push image
push-image:
    docker push fpco/alpine-haskell-stack:9.2.5

# Build nix image
build-nix-image:
    nix-build -v ghc-musl.nix

# Load nix image
load-nix-image:
    docker load < result
