#!/bin/bash

set -e

BUILD_DIR=build
TARGET=$1
TOOLCHAIN_FILE=$2  # 第二个参数：toolchain 路径

if [[ "$TARGET" == "clean" ]]; then
    rm -rf $BUILD_DIR
    echo "🧹 已清理构建目录"
    exit 0
fi

mkdir -p $BUILD_DIR
cd $BUILD_DIR

CMAKE_CMD="cmake .."

# 加入交叉编译配置（优先使用传入的 toolchain 文件）
if [[ -n "$TOOLCHAIN_FILE" ]]; then
    CMAKE_CMD+=" -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_FILE"
fi

# 支持模块选择
if [[ "$TARGET" == "slave" ]]; then
    CMAKE_CMD+=" -DTARGET_SLAVE=ON"
elif [[ "$TARGET" == "master" ]]; then
    CMAKE_CMD+=" -DTARGET_MASTER=ON"
fi

echo "⚙️ 正在执行: $CMAKE_CMD"
eval $CMAKE_CMD

make -j$(nproc)
