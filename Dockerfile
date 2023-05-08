
FROM protobuf-toolchain
WORKDIR /usr/src/grpc-stacksmash
COPY ./ ./
RUN true \
	&& if [ -z "$(ls -A ./src/thirdparty/asio-grpc)" ]; then \
		# && git clone "http://github.com/Tradias/asio-grpc" /usr/src/src/thirdparty/asio-grpc \
		git submodule update --init --recursive \
	;fi \
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
