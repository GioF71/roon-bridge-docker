ARG SELECT_IMAGE=${BASE_IMAGE}
FROM ${SELECT_IMAGE:-debian:bookworm-slim} AS base

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y curl lbzip2 alsa-utils && \
    rm -rf /var/lib/apt/lists/*

FROM scratch
COPY --from=base / /

LABEL maintainer="GioF71"
LABEL source="https://github.com/GioF71/roon-bridge-docker"

VOLUME /files

RUN mkdir -p /app/bin

ENV FORCE_ARCH=""
ENV BASE_URL=""

COPY app/bin/run-bridge.sh /app/bin/
RUN chmod +x /app/bin/*.sh

WORKDIR /app/bin

ENTRYPOINT ["/app/bin/run-bridge.sh"]
