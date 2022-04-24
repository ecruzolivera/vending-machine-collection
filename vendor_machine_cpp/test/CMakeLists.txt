find_package(Catch2 REQUIRED)

include(CTest)
include(Catch)

add_library(catch_main OBJECT catch_main.cpp)
target_link_libraries(catch_main PUBLIC Catch2::Catch2 ${CMAKE_PROJECT_NAME}lib)
target_link_libraries(catch_main PRIVATE project_options)

add_executable(tests tst_VendingMachine.cpp tst_VendingMachineFsm.cpp)
target_link_libraries(tests PRIVATE project_warnings project_options catch_main)

# automatically discover tests that are defined in catch based test files you can modify the tst. Set TEST_PREFIX
# to whatever you want, or use different for different binaries
catch_discover_tests(
  tests
  REPORTER
  junit
  OUTPUT_DIR
  .
  OUTPUT_PREFIX
  "junit."
  OUTPUT_SUFFIX
  .xml)
