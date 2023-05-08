
FROM ubuntu-2004-toolchain AS grpc-toolchain

ENV CC_FLAGS "-fsanitize=address -fno-omit-frame-pointer"
ENV CXX_FLAGS "-fsanitize=address -fno-omit-frame-pointer"
ENV LDFLAGS "-fsanitize=address -fno-omit-frame-pointer"

#
# Build and install CMake. Using 3.23.1 in my pipeline, so that is default here.
ARG CMAKE_VERSION=v3.23.1
WORKDIR /usr/src/cmake
RUN true \
	&& git clone \
		--branch "${CMAKE_VERSION}" \
		"https://github.com/kitware/cmake" \
	&& cd cmake \
	&& git submodule update \
		--init \
		--recursive \
	&& mkdir cmake-build \
	&& cd cmake-build \
	&& ../bootstrap \
	&& make -j"$(nproc)" \
	&& make install \
	&& cpack -G "DEB" \
	&& mkdir -p /usr/local/dist/cmake \
	&& cp *.deb /usr/local/dist/cmake \
	&& true

ARG PROTOBUF_VERSION=v21.12
WORKDIR /usr/src/protobuf
RUN true \
	&& git clone \
		--branch "${PROTOBUF_VERSION}" \
		"https://github.com/protocolbuffers/protobuf" \
	&& cd protobuf \
	&& git submodule update \
		--init \
		--recursive \
	&& mkdir build \
	&& cd build \
	&& cmake \
		-DCMAKE_BUILD_TYPE="Debug" \
		../ \
	&& make -j"$(nproc)" \
	&& make install \
	&& true

ARG GRPC_VERSION=v1.54.1
WORKDIR /usr/src/grpc
RUN true \
	&& git clone \
		--branch "${GRPC_VERSION}" \
		"https://github.com/grpc/grpc" \
	&& cd grpc \
	&& git submodule update \
		--init \
		--recursive \
	&& mkdir build \
	&& cd build \
	&& cmake \
		-DCMAKE_BUILD_TYPE="Debug" \
		-DCPACK_GENERATOR="DEB" \
		../ \
	&& make -j"$(nproc)" \
	&& make install \
	&& cpack \
	&& mkdir -p /usr/local/dist/grpc \
	&& cp *.deb /usr/local/dist/grpc \
	&& true
