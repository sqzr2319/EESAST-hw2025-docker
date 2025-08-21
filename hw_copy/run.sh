#!/usr/bin/env bash

# 该脚本演示如何构建并运行 hw_copy 镜像。
# 构建时会在镜像内编译 add/mul；运行时通过入口脚本 calc 选择要执行的程序。

set -euo pipefail

ROOT_DIR=$(cd "$(dirname "$0")"/.. && pwd)

# 构建镜像（以仓库根目录为构建上下文）
docker build -t eesast-hw-copy:latest -f "$ROOT_DIR/hw_copy/Dockerfile" "$ROOT_DIR"

echo "\n示例：运行 add 计算 3 + 5"
docker run --rm eesast-hw-copy:latest add 3 5

echo "\n示例：运行 mul 计算 6 * 7"
docker run --rm eesast-hw-copy:latest mul 6 7