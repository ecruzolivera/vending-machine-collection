include(FetchContent)

FetchContent_Declare(
  QuickFlux
  PREFIX "${PROJECT_BINARY_DIR}/QuickFlux-build"
      GIT_REPOSITORY "https://github.com/ecruzolivera/quickflux.git"
      CMAKE_ARGS "-DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}"
                      "-DCMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}/QuickFlux"
                      "-DCMAKE_INSTALL_LIBDIR=${PROJECT_BINARY_DIR}/QuickFlux/lib"
                      "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
                      )

FetchContent_MakeAvailable(QuickFlux)
