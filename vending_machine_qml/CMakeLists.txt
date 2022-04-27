cmake_minimum_required(VERSION 3.14.0)

project(vending_machine_qml LANGUAGES CXX)

set(PROJECT_VERSION_MAJOR 0)
set(PROJECT_VERSION_MINOR 1)
set(PROJECT_VERSION_PATCH 0)
set(PROJECT_VERSION
    ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH})
set(PROJECT_MAINTAINER "Ernesto Cruz Olivera")
set(PROJECT_MAINTAINER_EMAIL "ecruzolivera@gmail.com")
set(PROJECT_GIT_URL "https://gitlab.com/ecruzolivera/${PROJECT_NAME}")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# compiler options
include(cmake/StandardProjectSettingsConfig.cmake)

# standard compiler warnings
include(cmake/CompilerOptionsAndWarningsConfig.cmake)
set(project_options_and_warnings ${PROJECT_NAME}_project_options_and_warnings)
add_library(${project_options_and_warnings} INTERFACE)
set_project_options_and_warnings(${project_options_and_warnings})

# enable doxygen
include(cmake/DoxygenConfig.cmake)

# project satinizers
include(cmake/Sanitizers.cmake)
enable_sanitizers(project_options_and_warnings)

# static analyzers
include(cmake/CppCheckConfig.cmake)
include(cmake/ClangTidyConfig.cmake)
# include(cmake/StaticAnalyzers.cmake)

add_subdirectory(app)

option(ENABLE_TESTING "Enable Test Builds" ON)

if(ENABLE_TESTING)
  message(STATUS "Building Tests")
  include(CTest)
  add_subdirectory(tests)
endif()
