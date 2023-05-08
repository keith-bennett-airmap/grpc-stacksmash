
FROM cmake-toolchain

ENV CC_FLAGS "-fsanitize=address -fno-omit-frame-pointer"
ENV CXX_FLAGS "-fsanitize=address -fno-omit-frame-pointer"
ENV LDFLAGS "-fsanitize=address -fno-omit-frame-pointer"

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
