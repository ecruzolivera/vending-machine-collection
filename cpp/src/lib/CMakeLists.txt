project(${CMAKE_PROJECT_NAME}lib)

set(SRC_FILES
    VendingMachine.h
    VendingMachine.cpp
    VendingMachineOperations.h
    VendingMachineOperations.cpp
    VendingMachineFsm.h
    VendingMachineFsm.cpp)

add_library(${PROJECT_NAME} ${SRC_FILES})

target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(${PROJECT_NAME} PRIVATE project_options project_warnings)
