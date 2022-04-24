cmake_minimum_required(VERSION 3.14)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

include(cmake/FindQuickFlux.cmake)
include(cmake/FindQSyncable.cmake)
include(cmake/FindDuperAgent.cmake)

set(QML_IMPORT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/qml ${CMAKE_BINARY_DIR}/imports CACHE STRING "" FORCE)

message(STATUS "QML_IMPORT_PATH: ${QML_IMPORT_PATH}")

# QtCreator supports the following variables for Android, which are identical to
# qmake Android variables. Check https://doc.qt.io/qt/deployment-android.html
# for more information. They need to be set before the find_package(...) calls
# below.

# if(ANDROID) set(ANDROID_PACKAGE_SOURCE_DIR
# "${CMAKE_CURRENT_SOURCE_DIR}/android") if (ANDROID_ABI STREQUAL "armeabi-v7a")
# set(ANDROID_EXTRA_LIBS ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
# ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so) endif() endif()

find_package(
  QT NAMES Qt6 Qt5
  COMPONENTS Core Quick LinguistTools
  REQUIRED)

find_package(
  Qt${QT_VERSION_MAJOR}
  COMPONENTS Core Quick LinguistTools
  REQUIRED)

set(CPP_FILES cpp/uuid.h cpp/uuid.cpp)
set(TS_FILES ${PROJECT_NAME}_en_US.ts)
set(PROJECT_SOURCES main.cpp qml/qml.qrc ${CPP_FILES} ${TS_FILES})

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
  qt_add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})
  qt_create_translation(QM_FILES ${CMAKE_CURRENT_SOURCE_DIR} ${TS_FILES})
else()
  if(ANDROID)
    add_library(${PROJECT_NAME} SHARED ${PROJECT_SOURCES})
  else()
    add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})
  endif()
  qt5_create_translation(QM_FILES ${CMAKE_CURRENT_SOURCE_DIR} ${TS_FILES})
endif()

target_compile_definitions(
  ${PROJECT_NAME}
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

add_dependencies(${PROJECT_NAME} QuickFlux::quickflux)
add_dependencies(${PROJECT_NAME} QSyncable)
add_dependencies(${PROJECT_NAME} DuperAgent)
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE Qt${QT_VERSION_MAJOR}::Core
                                              Qt${QT_VERSION_MAJOR}::Quick)
target_link_libraries(${PROJECT_NAME} PRIVATE QuickFlux::quickflux QSyncable DuperAgent)
