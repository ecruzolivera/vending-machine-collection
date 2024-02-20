#!/bin/bash
./build_scripts/config.sh release -DENABLE_DOXYGEN=ON -DDOXYGEN_EXCLUDE_PATTERNS="vendor/*"
rm -rfv ./build/html
cmake --build ./build --target doxygen-docs
