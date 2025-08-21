FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
		&& apt-get install -y --no-install-recommends g++ ca-certificates \
		&& rm -rf /var/lib/apt/lists/*

WORKDIR /work

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