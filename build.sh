#!/bin/bash

set -e

BUILD_DIR=build
TARGET=$1

if [[ "$TARGET" == "clean" ]]; then
    rm -rf $BUILD_DIR
    echo "🧹 已清理构建目录"
    exit 0
fi

mkdir -p $BUILD_DIR
cd $BUILD_DIR

# 支持模块选择
if [[ "$TARGET" == "slave" ]]; then
    cmake .. -DTARGET_SLAVE=ON
elif [[ "$TARGET" == "master" ]]; then
    cmake .. -DTARGET_MASTER=ON
else
    cmake ..
fi

make -j$(nproc)
