FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
		&& apt-get install -y --no-install-recommends g++ ca-certificates \
		&& rm -rf /var/lib/apt/lists/*

WORKDIR /work

# 提供一个入口脚本：
# - 第一个参数：源文件名（如 add.cpp 或 mul.cpp），该文件应存在于挂载的 /work 目录
# - 其余参数：传递给编译出的可执行文件
RUN set -eux; \
	echo '#!/usr/bin/env bash'                                           >  /usr/local/bin/build_and_run; \
	echo 'set -euo pipefail'                                             >> /usr/local/bin/build_and_run; \
	echo 'if [[ $# -lt 1 ]]; then echo "Usage: <file.cpp> [args...]"; exit 1; fi' >> /usr/local/bin/build_and_run; \
	echo 'src="$1"; shift || true'                                     >> /usr/local/bin/build_and_run; \
	echo 'if [[ ! -f "/work/${src}" ]]; then echo "Source not found: ${src}"; exit 2; fi' >> /usr/local/bin/build_and_run; \
	echo 'base="${src%.cpp}"'                                          >> /usr/local/bin/build_and_run; \
	echo 'out="/work/${base}"'                                         >> /usr/local/bin/build_and_run; \
	echo 'echo "Compiling ${src} -> ${out}"'                           >> /usr/local/bin/build_and_run; \
	echo 'g++ -O2 "/work/${src}" -o "${out}"'                        >> /usr/local/bin/build_and_run; \
	echo 'chmod +x "${out}"'                                           >> /usr/local/bin/build_and_run; \
	echo 'if [[ $# -gt 0 ]]; then echo "Running: ${base} $*"; exec "${out}" "$@"; else echo "Built: ${out}"; fi' >> /usr/local/bin/build_and_run; \
	chmod +x /usr/local/bin/build_and_run

ENTRYPOINT ["/usr/local/bin/build_and_run"]