#!/usr/bin/env bash

docker system prune -f
docker image rm protobuf-toolchain protobuf-stacksmash
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

"${HERE}/docker/build.sh"

docker build -t protobuf-stacksmash ./
docker run protobuf-stacksmash
