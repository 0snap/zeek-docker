## raw base image for the zeek communication library broker

FROM debian:stretch

RUN apt-get update && apt-get install -y \
    build-essential \
    ca-certificates \
    cmake \
    git \
    libcurl4-openssl-dev \
    librocksdb-dev \
    libssl1.0-dev \
    python3-dev \
    swig \
    --no-install-recommends

RUN git clone --recursive https://github.com/zeek/broker.git /opt/broker-git
WORKDIR /opt/broker-git
RUN ./configure
RUN make -j4
RUN make install