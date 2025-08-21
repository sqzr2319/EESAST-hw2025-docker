#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR=$(cd "$(dirname "$0")"/.. && pwd)
SRC_DIR="$ROOT_DIR/src"

docker build -t eesast-hw-vol:latest -f "$ROOT_DIR/hw_vol/Dockerfile" "$ROOT_DIR"

echo "\n演示：编译并运行 add.cpp (2 + 8)"
docker run --rm -v "$SRC_DIR":/work eesast-hw-vol:latest add.cpp 2 8

echo "\n演示：编译并运行 mul.cpp (9 * 9)"
docker run --rm -v "$SRC_DIR":/work eesast-hw-vol:latest mul.cpp 9 9

echo "\n宿主机可执行文件列表："
ls -l "$SRC_DIR" | sed -n '1,5p'