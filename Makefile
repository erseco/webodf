CMAKE ?= cmake
CMAKE_BUILD_DIR ?= build
CMAKE_BUILD_TARGET ?= webodf.js-target
CMAKE_FLAGS ?=

BREW_PACKAGES := cmake qt@5 node openjdk
DEB_PACKAGES := cmake default-jdk libqt5webkit5-dev nodejs npm

ifdef OVERRIDE_VERSION
CMAKE_VERSION_ARG := -DOVERRULED_WEBODF_VERSION=$(OVERRIDE_VERSION)
endif

.PHONY: install-dependencies-mac install-dependencies-deb configure build clean

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
