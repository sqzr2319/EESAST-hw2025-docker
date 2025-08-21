FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
	&& apt-get install -y --no-install-recommends g++ ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY src ./src
RUN mkdir -p /usr/local/bin \
	&& g++ -O2 ./src/add.cpp -o /usr/local/bin/add \
	&& g++ -O2 ./src/mul.cpp -o /usr/local/bin/mul

RUN set -eux; \
	echo '#!/usr/bin/env bash'                                    >  /usr/local/bin/calc; \
	echo 'set -euo pipefail'                                      >> /usr/local/bin/calc; \
	echo 'if [[ $# -lt 3 ]]; then'                                >> /usr/local/bin/calc; \
	echo '  echo "Usage: <add|mul> <num1> <num2>"; exit 1; fi'  >> /usr/local/bin/calc; \
	echo 'case "$1" in'                                         >> /usr/local/bin/calc; \
	echo '  add|mul) cmd="$1" ;;'                               >> /usr/local/bin/calc; \
	echo '  *) echo "First arg must be add or mul"; exit 1;;'   >> /usr/local/bin/calc; \
	echo 'esac'                                                   >> /usr/local/bin/calc; \
	echo 'shift'                                                  >> /usr/local/bin/calc; \
	echo 'exec "/usr/local/bin/${cmd}" "$@"'                  >> /usr/local/bin/calc; \
	chmod +x /usr/local/bin/calc

ENTRYPOINT ["/usr/local/bin/calc"]