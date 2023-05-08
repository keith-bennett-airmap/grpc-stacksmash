#!/usr/bin/env bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

"${HERE}/docker/build.sh"

docker image rm grpc-stacksmash
docker system prune -f
docker build -t grpc-stacksmash ./
docker run grpc-stacksmash
