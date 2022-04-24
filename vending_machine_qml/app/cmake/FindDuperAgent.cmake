include(FetchContent)

FetchContent_Declare(
  DuperAgent
  PREFIX "${PROJECT_BINARY_DIR}/QSyncable-build"
      GIT_REPOSITORY "https://github.com/ecruzolivera/duperagent.git"
      CMAKE_ARGS "-DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}"
                      "-DCMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}/DuperAgent"
                      "-DCMAKE_INSTALL_LIBDIR=${PROJECT_BINARY_DIR}/DuperAgent/lib"
                      "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
                      )

FetchContent_MakeAvailable(DuperAgent)
