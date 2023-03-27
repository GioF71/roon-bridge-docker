# Roon Bridge on Docker

## Disclaimer

This is experimental. I do not even have Roon myself.  

## Build docker image

Use the included script to build the image:

`./build.sh`

## Run

Use the `roon` directory in the repo itself, and run:

```
docker run \
    --rm \
    -it \
    --name roon-bridge \
    -v ./roon:/roon \
    --network host \
    --device /dev/snd \
    giof71/roon-bridge:local-bullseye
```

## Environment Variables

Variable|Description
:---|:---
FORCE_ARCH|If set, we are not using `uname -m` to select architecture. Useful for example with LibreElec, which reports `aarch64` even when if should report `armv7l`. Possible values are `aarch64`, `armv7l` and `x86_64`