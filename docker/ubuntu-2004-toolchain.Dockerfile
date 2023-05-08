
FROM ubuntu:20.04
WORKDIR /usr/src/
COPY ./ ./
ENV DEBIAN_FRONTEND=noninteractive
#
# Install toolchains.
RUN true\
	&& apt-get update \
	&& apt-get install -y \
		ca-certificates \
		curl \
		gpg \
		lsb-release \
		software-properties-common \
	&& add-apt-repository -y --no-update ppa:ubuntu-toolchain-r/test \
	&& apt-get update \
	&& apt-get install -y \
		build-essential \
		git \
		libssl-dev \
		dpkg \
		gcc-11 \
		g++-11 \
		autoconf \
		automake \
		libtool \
		unzip \
	&& update-alternatives \
		--install /usr/bin/gcc gcc /usr/bin/gcc-11 \
		11 \
		--slave /usr/bin/g++ g++ /usr/bin/g++-11 \
		--slave /usr/bin/gcov gcov /usr/bin/gcov-11 \
	&& rm -Rf /var/lib/apt/lists/* \
	&& true
