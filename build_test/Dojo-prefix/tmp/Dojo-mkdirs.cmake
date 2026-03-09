# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "/home/runner/work/webodf/webodf/build_test/Dojo-prefix/src/Dojo")
  file(MAKE_DIRECTORY "/home/runner/work/webodf/webodf/build_test/Dojo-prefix/src/Dojo")
endif()
file(MAKE_DIRECTORY
  "/home/runner/work/webodf/webodf/build_test/Dojo-prefix/src/Dojo-build"
  "/home/runner/work/webodf/webodf/build_test/Dojo-prefix"
  "/home/runner/work/webodf/webodf/build_test/Dojo-prefix/tmp"
  "/home/runner/work/webodf/webodf/build_test/Dojo-prefix/src/Dojo-stamp"
  "/home/runner/work/webodf/webodf/build_test/downloads"
  "/home/runner/work/webodf/webodf/build_test/Dojo-prefix/src/Dojo-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/runner/work/webodf/webodf/build_test/Dojo-prefix/src/Dojo-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/runner/work/webodf/webodf/build_test/Dojo-prefix/src/Dojo-stamp${cfgdir}") # cfgdir has leading slash
endif()
