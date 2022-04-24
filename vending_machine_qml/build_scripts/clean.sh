#!/bin/bash
if [[ -d ./build ]]; then
    rm -rfv ./build
else
    echo "nothing to clean"
fi
