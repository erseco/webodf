# Contributing to WebODF

Thanks for helping improve WebODF.

## Project structure

The repository is split into a few main areas:

* `webodf/lib/` contains the core JavaScript runtime, ODF model, and rendering code.
* `webodf/tests/` contains the unit and integration-style test suites that back `webodf.js-tests`.
* `viewer/` contains the local demo viewer that is served by `make serve`.
* `examples/` contains sample OpenDocument files used by the demo and manual testing.
* `programs/` contains higher-level products and integrations built on top of the core library.
* `ci/` and `.github/workflows/` contain the dependency list and CI automation used for builds and deployment.

## Build and test commands

From the repository root:

    make configure
    make build

The initial build downloads some external tools into `build/`, so internet access is required the first time. If you need platform-specific dependency steps, use `make install-dependencies-deb`, `make install-dependencies-mac`, or follow [README-Building.md](README-Building.md).

After configuring, the most useful validation targets are:

    cmake --build build --target syntaxcheck
    cmake --build build --target simplenodetest
    cmake --build build --target webodf.js-tests

For a full distributable library build, run:

    cmake --build build --target product-library

## Coding expectations

* Keep changes focused and update the related tests or documentation when behavior changes.
* Follow the Closure-style typing rules documented in [CodingStandards.md](CodingStandards.md), especially the explicit nullability and `@return` requirements.
* Reuse the existing build and test targets instead of adding one-off scripts.
* When touching developer-facing workflows, verify them locally when possible (for example with `make build` or `make serve`).

## Release process

Releases are driven by the existing CMake product targets and the GitHub Actions workflow:

1. Build and validate the library from a clean checkout.
2. Produce distributable artifacts such as `product-library` from the configured `build/` directory.
3. Pushes to `main` and version tags matching `v*` run `.github/workflows/ci.yml`.
4. Tagged builds keep the tagged version, while branch builds use `0.0.0-build<commit>`.
5. Pushes to `main` and version tags publish `build/webodf/webodf.js`, `viewer/`, and `examples/` to `gh-pages`.

If you are preparing a release, make sure the relevant product target succeeds locally before pushing the branch or tag.
