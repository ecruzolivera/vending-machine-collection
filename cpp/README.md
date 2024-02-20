# vending-machine-cpp

Toy project for learning C++ 20

## How to build

This project build system (CMake+Conan) is based on the [Cpp Starter Project template](https://github.com/cpp-best-practices/cpp_starter_project)

- 1. Install all necessary Dependencies following [this guide](https://github.com/cpp-best-practices/cpp_starter_project/blob/main/README_dependencies.md#necessary-dependencies)
- 2. Build the app with: `cmake . --preset linux-gcc-debug && cmake --build out/build/linux-gcc-debug`
- 3. Run the app with: `./out/build/linux-gcc-debug/src/cli/vending_machine_cpp`
- 4. Run the unit tests with: `ctest --test-dir ./out/build/linux-gcc-debug`
