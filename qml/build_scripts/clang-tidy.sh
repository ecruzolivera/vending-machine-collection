#!/bin/bash
# ./build_scripts/config.sh debug -DENABLE_TESTING=ON
# find $1 -iname *.h -o -iname *.c -o -iname *.cpp -o -iname *.hpp | xargs clang-tidy -p ./build

./build_scripts/build.sh debug -DENABLE_TESTING=ON -DENABLE_CLANG_TIDY=ON
