# 指定目标平台
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

# 设置工具链路径（你根据实际路径调整）
set(TOOLCHAIN_PATH "${CMAKE_CURRENT_LIST_DIR}/toolchains/arm-sunplus/arm-9.2_eabihf/bin")

# 指定编译器
set(CMAKE_C_COMPILER   ${TOOLCHAIN_PATH}/arm-none-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PATH}/arm-none-linux-gnueabihf-g++)

# 关闭默认路径搜索
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
