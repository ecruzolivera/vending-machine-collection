#!/bin/bash
mkdir -p build/scan_build
cd build
export CCC_ANALYZER_CPLUSPLUS
scan-build -o scan_build cmake .. -G Ninja -DCMAKE_BUILD_TYPE:STRING=Debug \
    -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_VERBOSE_MAKEFILE=ON -DENABLE_EXAMPLES=ON

scan-build -o scan_build cmake --build .
