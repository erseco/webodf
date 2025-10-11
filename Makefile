CMAKE ?= cmake
CMAKE_BUILD_DIR ?= build
CMAKE_BUILD_TARGET ?= webodf.js-target
CMAKE_FLAGS ?=
OVERRIDE_VERSION ?= 0.0.0

BREW_PACKAGES := cmake qt@5 node openjdk
DEB_PACKAGES := cmake default-jdk libqt5webkit5-dev nodejs npm

CMAKE_VERSION_ARG := -DOVERRULED_WEBODF_VERSION=$(OVERRIDE_VERSION)

.DEFAULT_GOAL := help

.PHONY: help install-dependencies-mac install-dependencies-deb configure build clean

help:
	@echo "WebODF Make targets:"
	@echo "  make install-dependencies-mac   # Install build prerequisites using Homebrew"
	@echo "  make install-dependencies-deb   # Install build prerequisites using apt"
	@echo "  make configure                  # Run CMake configure step"
	@echo "  make build                      # Configure and build $(CMAKE_BUILD_TARGET)"
	@echo "  make clean                      # Remove $(CMAKE_BUILD_DIR)"
	@echo
	@echo "Variables:"
	@echo "  OVERRIDE_VERSION (default: $(OVERRIDE_VERSION))"
	@echo "  CMAKE_FLAGS (extra args passed to CMake configure)"
	@echo "Example: make build OVERRIDE_VERSION=1.2.3"

install-dependencies-mac:
	brew update
	brew install $(BREW_PACKAGES)

install-dependencies-deb:
	sudo apt-get update
	sudo apt-get install -y $(DEB_PACKAGES)

configure:
	$(CMAKE) -S . -B $(CMAKE_BUILD_DIR) $(CMAKE_VERSION_ARG) $(CMAKE_FLAGS)

build: configure
	$(CMAKE) --build $(CMAKE_BUILD_DIR) --target $(CMAKE_BUILD_TARGET)

clean:
	rm -rf $(CMAKE_BUILD_DIR)
