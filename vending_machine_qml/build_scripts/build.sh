#!/bin/bash
./build_scripts/config.sh ${@:1}
cmake --build ./build
