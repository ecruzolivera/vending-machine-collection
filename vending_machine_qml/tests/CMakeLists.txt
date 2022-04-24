project(tests)

include(FetchContent)

FetchContent_Declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG v2.13.3)

FetchContent_MakeAvailable(Catch2)

option(ENABLE_JUNT_XML_TEST_REPORT "Enable catch2 junit compatible test report"
       OFF)

enable_testing()

if(MINGW)
  message(
    WARNING
      "Using MingW compiler, expect long linking times due a catch2 issue with that compiler"
  )
endif()

set(TEST_SRC_FILES ${CMAKE_CURRENT_SOURCE_DIR}/tst_dumy.cpp
                   ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)

add_executable(${PROJECT_NAME} ${TEST_SRC_FILES})

target_link_libraries(${PROJECT_NAME} Catch2::Catch2)

if(ENABLE_JUNT_XML_TEST_REPORT)
  add_test(NAME ${PROJECT_NAME} COMMAND ${PROJECT_NAME} -o test_report.xml -r
                                        junit)
  message(STATUS "Test junit output in the test_report.xml file")
else()
  add_test(${PROJECT_NAME} ${PROJECT_NAME})
endif()
