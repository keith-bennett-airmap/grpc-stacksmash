#!/usr/bin/env bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ -z "$(docker image ls -q ubuntu-2004-toolchain)" ]; then
	docker build -t ubuntu-2004-toolchain -f "${HERE}/ubuntu-2004-toolchain.Dockerfile" "${HERE}"
fi
if [ -z "$(docker image ls -q cmake-toolchain)" ]; then
	docker build -t cmake-toolchain -f "${HERE}/cmake-toolchain.Dockerfile" "${HERE}"
fi
if [ -z "$(docker image ls -q protobuf-toolchain)" ]; then
	docker build -t protobuf-toolchain -f "${HERE}/protobuf-toolchain.Dockerfile" "${HERE}"
fi

echo "Toolchain found or built."
