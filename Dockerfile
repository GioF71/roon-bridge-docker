FROM debian:bullseye-slim AS BASE

ARG USE_APT_PROXY

RUN mkdir -p /app/conf

RUN echo "USE_APT_PROXY=["${USE_APT_PROXY}"]"

COPY app/conf/01-apt-proxy /app/conf/

RUN if [ "${USE_APT_PROXY}" = "Y" ]; then \
    echo "Builind using apt proxy"; \
    cp /app/conf/01-apt-proxy /etc/apt/apt.conf.d/01-apt-proxy; \
    cat /etc/apt/apt.conf.d/01-apt-proxy; \
    else \
    echo "Building without apt proxy"; \
    fi

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y lbzip2
RUN apt-get install -y alsa-utils

RUN rm -rf /var/lib/apt/lists/*

FROM scratch
COPY --from=BASE / /

LABEL maintainer="GioF71"
LABEL source="https://github.com/GioF71/roon-bridge-docker"

VOLUME /roon

RUN mkdir -p /app
RUN mkdir -p /app/bin
RUN mkdir -p /app/doc

ENV FORCE_ARCH ""
ENV STARTUP_DELAY_SEC ""

COPY app/bin/run-bridge.sh /app/bin/
RUN chmod +x /app/bin/*.sh

COPY README.md /app/doc/

WORKDIR /app/bin

ENTRYPOINT ["/app/bin/run-bridge.sh"]
