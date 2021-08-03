#!/bin/bash -ex
####################################################################################################
# Runs the FyPro tests
####################################################################################################

SCRIPT_DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )
SOURCE_DIR=${SCRIPT_DIR}/..

[ ! -d ${PWD}/_test ] \
    || { echo "Test folder '_test' already exists." >&2; exit 1; }
mkdir _test
cd _test

source ${SOURCE_DIR}/activate.sh

fypro new MyProject

mkdir test-myproject
cd test-myproject

mkdir build
mkdir install

cd build
cmake ../../myproject -G Ninja -DCMAKE_INSTALL_PREFIX=${PWD}/../install
ninja
ninja install
ctest
cd ..

mkdir cmake
cd cmake
CMAKE_PREFIX_PATH=${PWD}/../install cmake -G Ninja ../../myproject/test/export/cmake
ninja
./test_export
cd ..

mkdir pkgconfig
cd pkgconfig
PKG_CONFIG_PATH=${PWD}/../install/lib/pkgconfig \
    ../../myproject/test/export/pkgconfig/test_export.sh
./test_export
cd ..
