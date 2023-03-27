# Roon Bridge on Docker

## Disclaimer

This is experimental. I do not even have Roon myself.  

## Build docker image

Use the included script to build the image:

`./build.sh`

## Run

You can use the published images or the one you build by yourself. See the repo [here](https://hub.docker.com/r/giof71/roon-bridge).  
Select a directory to be mapped to `/roon` in order to speed-up restarts, and run:

```
docker run \
    --rm \
    -it \
    --name roon-bridge \
    -v ./roon:/roon \
    --network host \
    --device /dev/snd \
    giof71/roon-bridge
```

## Environment Variables

Variable|Description
:---|:---
FORCE_ARCH|If set, we are not using `uname -m` to select architecture. Useful for example with LibreElec, which reports `aarch64` even when if should report `armv7l`. Possible values are `aarch64`, `armv7l` and `x86_64`
