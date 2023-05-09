
FROM cmake-toolchain

ENV CC_FLAGS "-fsanitize=address -fno-omit-frame-pointer"
ENV CXX_FLAGS "-fsanitize=address -fno-omit-frame-pointer"
ENV LDFLAGS "-fsanitize=address -fno-omit-frame-pointer"

ARG PROTOBUF_VERSION=v23.0
WORKDIR /usr/src/protobuf
RUN true \
	&& git clone \
		--branch "${PROTOBUF_VERSION}" \
		"https://github.com/protocolbuffers/protobuf" \
	&& cd protobuf \
	&& git submodule update \
		--init \
		--recursive \
	&& if [ -f "./CMakeLists.txt" ]; then \
		mkdir build \
		&& cd build \
		&& cmake \
			-DCMAKE_BUILD_TYPE="Debug" \
			../ \
		&& make -j"$(nproc)" \
		&& make install \
	;else \
		./autogen.sh \
		&& ./configure \
		&& make -j"$(nproc)" \
		&& make check \
		&& make install \
		&& ldconfig \
	;fi \
	&& true
