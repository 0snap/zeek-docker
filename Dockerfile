FROM debian:buster

RUN apt-get update && apt-get install -y \
    bison \
    build-essential \
    ca-certificates \
    cmake \
    flex \
    gawk \
    git \
    libcurl4-openssl-dev \
    libgeoip-dev \
    libjemalloc-dev \
    libmaxminddb-dev \
    libncurses5-dev \
    libpcap-dev \
    librocksdb-dev \
    libssl-dev \
    python3-dev \
    python3-pip \
    swig \
    wget \
    zlib1g-dev \
    --no-install-recommends

# get latest zeek from source
RUN git clone --recursive https://github.com/zeek/zeek /opt/zeek-git
WORKDIR /opt/zeek-git
ARG ZEEK_VERSION
RUN git checkout ${ZEEK_VERSION:-master} && git fetch && git submodule update --recursive --init

RUN ./configure --with-jemalloc=/usr/lib/x86_64-linux-gnu
RUN make -j4 install

ENV PATH=/usr/local/zeek/bin:$PATH

VOLUME /usr/local/zeek/logs

RUN pip3 install setuptools wheel

RUN pip3 install zkg && \
    zkg autoconfig

COPY zkg.conf /root/.zkg/config
COPY zkg.conf /usr/local/zeek/zkg/config

EXPOSE 9999

WORKDIR /usr/local/zeek/logs
COPY entrypoint.sh /opt/zeek/entrypoint.sh
RUN chmod +x /opt/zeek/entrypoint.sh

ENTRYPOINT ["/opt/zeek/entrypoint.sh"]