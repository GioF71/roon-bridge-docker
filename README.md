# Roon Bridge on Docker

## Links

Repo|URL
:---|:---
Source code|[GitHub](https://github.com/GioF71/roon-bridge-docker)
Docker images|[Docker Hub](https://hub.docker.com/r/giof71/roon-bridge)

## Available Archs on Docker Hub

- linux/amd64
- linux/arm/v7
- linux/arm64/v8

## Build docker image

Use the included script to build the image:

`./build.sh`

## Environment Variables

Variable|Description
:---|:---
BASE_URL|If set, files are downloaded from that URL instead of from the roon servers
FORCE_ARCH|If set, we are using the value instead of `uname -m` when selecting the binary file to use/download. This can be useful for example with LibreElec or OSMC on the Pi4, which have a 64bit kernel (`aarch64`) but a 32bit docker version: in this situation, then container starts but then the binary does not work. Setting this variable to `armv7l` solved the issue for me. Possible values are `aarch64`, `armv7l` and `x86_64`.

## Volumes

Volume|Description
:---|:---
/files|If set, we try and see if the volume contains the files that would instead be downloaded. Setting this volume can speed up the startup phase slightly.

## Example

You can use the published images or the one you build by yourself. See the repo [here](https://hub.docker.com/r/giof71/roon-bridge).  

### Docker Run

```text
docker run \
    -d \
    --name roon-bridge \
    --restart always \
    --network host \
    --device /dev/snd \
    --label com.centurylinklabs.watchtower.enable=false \
    giof71/roon-bridge:latest
```

### Docker Compose

```text
---
version: "3"

services:
  roon-bridge:
    container_name: roon-bridge
    image: giof71/roon-bridge:latest
    network_mode: host
    devices:
      - /dev/snd:/dev/snd
    labels:
      - com.centurylinklabs.watchtower.enable=false
    restart: always
```

## Changelog

Date|Description
:---|:---
2023-03-29|Allow `BASE_URL` as alternate source for downloads
2023-03-29|Removed `/roon` mountpoint for ease of use
2023-03-29|Add volume `/files` for providing the necessary binary files (avoid downloads)
2023-03-27|Added `FORCE_ARCH` variable
