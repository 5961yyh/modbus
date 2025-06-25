cmake_minimum_required(VERSION 3.10)
project(modbus_slave_demo)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

file(GLOB LIBMODBUS_SRC "libmodbus/*.c")


option(TARGET_SLAVE "Build modbus slave" OFF)
option(TARGET_MASTER "Build modbus master" OFF)

if(TARGET_SLAVE)
    file(GLOB SLAVE_SRC "src/slave/*.cpp")
    add_executable(mod_slave ${SLAVE_SRC} ${LIBMODBUS_SRC})
    target_include_directories(mod_slave PRIVATE libmodbus)
endif()
