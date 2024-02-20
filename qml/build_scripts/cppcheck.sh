#!/bin/bash
report_path=cppcheck
xml_report_name=$report_path/cppcheck_report.xml

# exclude this files/folders
files_excluded=vendor/*

./build_scripts/config.sh debug -DENABLE_CPPCHECK=ON -DCPPCHECK_XML_OUTPUT=$xml_report_name
cmake --build ./build --target cppcheck_analysis
cppcheck_analysis_ret=$?

cd ./build

if [[ -x "$(command -v cppcheck-htmlreport)" ]]; then
    cppcheck-htmlreport --file=$xml_report_name --report-dir=$report_path --source-dir=./
else
    python ../build_scripts/cppcheck-htmlreport.py --file=$xml_report_name --report-dir=$report_path --source-dir=./
fi

exit $cppcheck_analysis_ret
