#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR=$(cd "$(dirname "$0")"/.. && pwd)

docker build -t eesast-hw-copy:latest -f "$ROOT_DIR/hw_copy/Dockerfile" "$ROOT_DIR"

echo "\n示例：运行 add 计算 3 + 5"
docker run --rm eesast-hw-copy:latest add 3 5

echo "\n示例：运行 mul 计算 6 * 7"
docker run --rm eesast-hw-copy:latest mul 6 7