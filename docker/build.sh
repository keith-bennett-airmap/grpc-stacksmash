#!/usr/bin/env bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ -z "$(docker image ls -q ubuntu-2004-toolchain)" ]; then
	docker build -t ubuntu-2004-toolchain -f "${HERE}/ubuntu-2004-toolchain.Dockerfile" "${HERE}"
fi
if [ -z "$(docker image ls -q grpc-toolchain)" ]; then
	docker build -t grpc-toolchain -f "${HERE}/grpc-toolchain.Dockerfile" "${HERE}"
fi

echo "Toolchain found or built."
