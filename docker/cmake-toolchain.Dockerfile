
FROM ubuntu-2004-toolchain

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
