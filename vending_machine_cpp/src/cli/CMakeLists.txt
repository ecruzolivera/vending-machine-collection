find_package(fmt CONFIG)

set(SRC_FILES main.cpp Cli.h Cli.cpp)

add_executable(${CMAKE_PROJECT_NAME} ${SRC_FILES})

target_link_libraries(
  ${CMAKE_PROJECT_NAME}
  PRIVATE ${CMAKE_PROJECT_NAME}lib
          project_options
          project_warnings
          fmt::fmt)

target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE "${CMAKE_BINARY_DIR}/configured_files/include")
