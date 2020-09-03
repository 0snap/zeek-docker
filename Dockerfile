FROM debian:buster

RUN apt-get -qq update && apt-get -qqy install \
    build-essential \
    ca-certificates \
    curl \
    git \
    gnupg2 \
    python3-dev \
    python3-pip \
    --no-install-recommends

RUN echo 'deb http://download.opensuse.org/repositories/security:/zeek/Debian_10/ /' | tee /etc/apt/sources.list.d/security:zeek.list && \
    curl -fsSL https://download.opensuse.org/repositories/security:zeek/Debian_10/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/security:zeek.gpg > /dev/null
RUN apt-get -qq update && apt-get -qqy install zeek
ENV PATH="/opt/zeek/bin:$PATH"

RUN python3 -m pip install setuptools wheel && \
    python3 -m pip install zkg && \
    zkg autoconfig

WORKDIR /var/log/zeek
VOLUME /var/log/zeek

EXPOSE 9999

ENTRYPOINT ["/opt/zeek/bin/zeek"]