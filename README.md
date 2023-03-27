# Roon Bridge on Docker

## Build

Use the included script to build the image:

`./build.sh`

## Install

Create a `roon` directory, maybe in the repo itself, and run:

```
docker run --rm \
    --name roon-bridge \
    -it -v ./roon:/roon \
    --entrypoint=/app/bin/install-bridge.sh \
    giof71/roon-bridge:local-bullseye
```

## Run

```
docker run --rm \
    --name roon-bridge \
    -it -v ./roon:/roon \
    --network host \
    --device /dev/snd \
    giof71/roon-bridge:local-bullseye
```