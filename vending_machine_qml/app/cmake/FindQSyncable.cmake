include(FetchContent)

FetchContent_Declare(
  QSyncable
  PREFIX "${PROJECT_BINARY_DIR}/QSyncable-build"
      GIT_REPOSITORY "https://github.com/ecruzolivera/qsyncable.git"
      CMAKE_ARGS "-DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}"
                      "-DCMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}/QSyncable"
                      "-DCMAKE_INSTALL_LIBDIR=${PROJECT_BINARY_DIR}/QSyncable/lib"
                      "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
                      )

FetchContent_MakeAvailable(QSyncable)
