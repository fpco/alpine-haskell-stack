MAKEFLAGS = -s

.DEFAULT_GOAL = help

# https://www.gnu.org/software/make/manual/html_node/Special-Variables.html
# https://ftp.gnu.org/old-gnu/Manuals/make-3.80/html_node/make_17.html
ALPINE_HASKELL_MKFILE_PATH := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
ALPINE_HASKELL_ROOT_DIR    := $(shell cd $(shell dirname $(ALPINE_HASKELL_MKFILE_PATH)); pwd)

# GHC version to build
TARGET_GHC_VERSION ?= 8.8.3

################################################################################
# Convenience targets for building GHC locally
#
# The intermediate layers of the multi-stage Docker build file are cached so
# that changes to the Dockerfile don't force us to rebuild GHC when developing

.PHONY: docker-build-gmp
## Build GHC with support for 'integer-gmp' and 'libgmp'
docker-build-gmp: docker-base-gmp docker-ghc-gmp docker-tooling-gmp docker-image-gmp

.PHONY: docker-base-gmp
docker-base-gmp:
	docker build \
	  --build-arg GHC_BUILD_TYPE=gmp \
	  --build-arg GHC_VERSION=$(TARGET_GHC_VERSION) \
	  --target base \
	  --tag alpine-haskell-gmp:base \
	  --cache-from alpine-haskell-gmp:base \
	  --file $(ALPINE_HASKELL_ROOT_DIR)/Dockerfile \
	  $(ALPINE_HASKELL_ROOT_DIR)

.PHONY: docker-ghc-gmp
docker-ghc-gmp:
	docker build \
	  --build-arg GHC_BUILD_TYPE=gmp \
	  --build-arg GHC_VERSION=$(TARGET_GHC_VERSION) \
	  --target build-ghc \
	  --tag alpine-haskell-gmp:build-ghc-$(TARGET_GHC_VERSION) \
	  --cache-from alpine-haskell-gmp:build-ghc-$(TARGET_GHC_VERSION) \
	  --cache-from alpine-haskell-gmp:base \
	  --file $(ALPINE_HASKELL_ROOT_DIR)/Dockerfile \
	  $(ALPINE_HASKELL_ROOT_DIR)

.PHONY: docker-tooling-gmp
docker-tooling-gmp:
	docker build \
	  --build-arg GHC_BUILD_TYPE=gmp \
	  --build-arg GHC_VERSION=$(TARGET_GHC_VERSION) \
	  --target build-tooling \
	  --tag alpine-haskell-gmp:build-tooling \
	  --cache-from alpine-haskell-gmp:build-tooling\
	  --cache-from alpine-haskell-gmp:build-ghc-$(TARGET_GHC_VERSION) \
	  --cache-from alpine-haskell-gmp:base \
	  --file $(ALPINE_HASKELL_ROOT_DIR)/Dockerfile \
	  $(ALPINE_HASKELL_ROOT_DIR)

.PHONY: docker-image-gmp
docker-image-gmp:
	docker build \
	  --build-arg GHC_BUILD_TYPE=gmp \
	  --build-arg GHC_VERSION=$(TARGET_GHC_VERSION) \
	  --tag alpine-haskell-gmp:$(TARGET_GHC_VERSION) \
          --tag fpco/alpine-haskell-stack:gmp-ghc-$(TARGET_GHC_VERSION) \
	  --cache-from alpine-haskell-gmp:$(TARGET_GHC_VERSION) \
	  --cache-from alpine-haskell-gmp:build-tooling \
	  --cache-from alpine-haskell-gmp:build-ghc-$(TARGET_GHC_VERSION) \
	  --cache-from alpine-haskell-gmp:base \
	  --file $(ALPINE_HASKELL_ROOT_DIR)/Dockerfile \
	  $(ALPINE_HASKELL_ROOT_DIR)


.PHONY: docker-build-simple
## Build GHC with support for 'integer-simple'
docker-build-simple: docker-base-simple docker-ghc-simple docker-tooling-simple docker-image-simple

.PHONY: docker-base-simple
docker-base-simple:
	docker build \
	  --build-arg GHC_BUILD_TYPE=simple \
	  --build-arg GHC_VERSION=$(TARGET_GHC_VERSION) \
	  --target base \
	  --tag alpine-haskell-simple:base \
	  --cache-from alpine-haskell-simple:base \
	  --file $(ALPINE_HASKELL_ROOT_DIR)/Dockerfile \
	  $(ALPINE_HASKELL_ROOT_DIR)

.PHONY: docker-ghc-simple
docker-ghc-simple:
	docker build \
	  --build-arg GHC_BUILD_TYPE=simple \
	  --build-arg GHC_VERSION=$(TARGET_GHC_VERSION) \
	  --target build-ghc \
	  --tag alpine-haskell-simple:build-ghc-$(TARGET_GHC_VERSION) \
	  --cache-from alpine-haskell-simple:build-ghc-$(TARGET_GHC_VERSION) \
	  --cache-from alpine-haskell-simple:base \
	  --file $(ALPINE_HASKELL_ROOT_DIR)/Dockerfile \
	  $(ALPINE_HASKELL_ROOT_DIR)

.PHONY: docker-tooling-simple
docker-tooling-simple:
	docker build \
	  --build-arg GHC_BUILD_TYPE=simple \
	  --build-arg GHC_VERSION=$(TARGET_GHC_VERSION) \
	  --target build-tooling \
	  --tag alpine-haskell-simple:build-tooling \
	  --cache-from alpine-haskell-simple:build-tooling\
	  --cache-from alpine-haskell-simple:build-ghc-$(TARGET_GHC_VERSION) \
	  --cache-from alpine-haskell-simple:base \
	  --file $(ALPINE_HASKELL_ROOT_DIR)/Dockerfile \
	  $(ALPINE_HASKELL_ROOT_DIR)

.PHONY: docker-image-simple
docker-image-simple:
	docker build \
	  --build-arg GHC_BUILD_TYPE=simple \
	  --build-arg GHC_VERSION=$(TARGET_GHC_VERSION) \
	  --tag alpine-haskell-simple:$(TARGET_GHC_VERSION) \
	  --cache-from alpine-haskell-simple:$(TARGET_GHC_VERSION) \
	  --cache-from alpine-haskell-simple:build-tooling \
	  --cache-from alpine-haskell-simple:build-ghc-$(TARGET_GHC_VERSION) \
	  --cache-from alpine-haskell-simple:base \
	  --file $(ALPINE_HASKELL_ROOT_DIR)/Dockerfile \
	  $(ALPINE_HASKELL_ROOT_DIR)

## Show help screen.
.PHONY: help
help:
	echo "Please use \`make <target>' where <target> is one of\n\n"
	awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "%-30s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
