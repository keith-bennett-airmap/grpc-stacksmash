
FROM protobuf-toolchain
WORKDIR /usr/src/grpc-stacksmash
COPY ./ ./
RUN true \
	&& cd src \
	&& mkdir -p ./build \
	&& cd ./build \
	&& cmake \
		-DCMAKE_BUILD_TYPE="Debug" \
		-DASAN_BUILD=ON \
		-DCPACK_GENERATOR="DEB" \
		../ \
	&& true
RUN true \
	&& cd src/build \
	&& make -j"$(nproc)" \
	# && make test \
	&& make install \
	&& cpack \
	&& dpkg -i ./*.deb \
	&& true

ENTRYPOINT [ "/usr/bin/greeter-service" ]
CMD "--help"
