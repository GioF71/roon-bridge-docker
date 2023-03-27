# Roon Bridge on Docker

## Disclaimer

This is experimental. I do not even have Roon myself.  

## Build docker image

Use the included script to build the image:

`./build.sh`

# Run

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
