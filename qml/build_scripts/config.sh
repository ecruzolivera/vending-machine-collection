#!/bin/bash
if [[ $1 == "debug" ]]; then
    cmake_config_str="-DCMAKE_BUILD_TYPE:STRING=Debug"
elif [[ $1 == "release" ]]; then
    cmake_config_str="-DCMAKE_BUILD_TYPE:STRING=Release -DWARNINGS_AS_ERRORS=ON"

fi

cmake -S . -B ./build -G Ninja $cmake_config_str -DNO_EXCEPTIONS=ON \
    -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_VERBOSE_MAKEFILE=ON ${@:2}
