#!/bin/bash
if [[ $1 == "junit" ]]; then
    report_config_str="-DENABLE_JUNT_XML_TEST_REPORT=ON"
else
    report_config_str=""
fi
./build_scripts/build.sh debug -DENABLE_TESTING=ON $report_config_str
cd build
ctest -VV
