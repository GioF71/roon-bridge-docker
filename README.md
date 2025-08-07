# Roon Bridge on Docker

## Links

Repo|URL
:---|:---
Source code|[GitHub](https://github.com/GioF71/roon-bridge-docker)
Docker images|[Docker Hub](https://hub.docker.com/r/giof71/roon-bridge)

## Support

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/H2H7UIN5D)  
Please see the [Goal](https://ko-fi.com/giof71/goal?g=0).  
Please note that support goal is limited to cover running costs for subscriptions to music services.

## Available Archs on Docker Hub

- linux/amd64
- linux/arm64/v8
- linux/arm/v7

### Install Docker

Docker is a prerequisite. On debian and derived distributions (this includes Raspberry Pi OS, DietPi, Moode Audio, Volumio, OSMC), we can install the necessary packages using the following commands:

```text
sudo apt-get update
sudo apt-get install -y docker.io docker-compose
sudo usermod -a -G docker $USER
```

The last command adds the current user to the docker group. This is not mandatory; if you choose to skip this step, you might need to execute docker-compose commands by prepending `sudo`.  
Please note that this is not necessarily the best way of installing docker on your machine. First of all, the suggested method installs the packages from the distribution repositories. You might prefer to install from the docker repositories in order to have a more updated version.  
You can use this solution with Podman as well. See [this discussion](https://github.com/GioF71/roon-bridge-docker/discussions/30).  

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

### Disabling watchtower

[Watchtower](https://containrrr.dev/watchtower/) is an excellent tool, but it can disrupt your listening experience if an image update can trigger a container recreation.  
I am therefore keeping watchtower disabled in my examples.  

## Installation on Moode Audio or Volumio

It is possible to use this solution for easy installation of Roon Bridge on [Moode Audio](https://moodeaudio.org/) and [Volumio](https://volumio.com/).  
It is required to have a ssh connection to the Moode/Volumio audio box. In order to enable ssh on Volumio, refer to [this](https://developers.volumio.com/SSH%20Connection) page.  
Those two platforms do not ship docker out of the box (unsurprisingly), so docker installation is required. See [Docker Installation](#install-docker) earlier in this page.  

## Changelog

Date|Description
:---|:---
2025-02-16|Dockerfile cleanup
2025-02-12|Bump to debian stable (for real this time!)
2023-09-28|Switch to debian stable by default (see [#20](https://github.com/GioF71/roon-bridge-docker/issues/20))
2023-03-29|Allow `BASE_URL` as alternate source for downloads
2023-03-29|Removed `/roon` mountpoint for ease of use
2023-03-29|Add volume `/files` for providing the necessary binary files (avoid downloads)
2023-03-27|Added `FORCE_ARCH` variable
