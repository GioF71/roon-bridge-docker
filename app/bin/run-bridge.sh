#!/bin/bash

echo "Install bridge"

ROON_DIR="/roon-dir"

# might already exist
if [[ ! -d "$ROON_DIR" ]]; then
    mkdir $ROON_DIR
else
    echo "$ROON_DIR already exists"
fi

echo "Removing anything in $ROON_DIR ..."
rm $ROON_DIR/* -Rf
echo "Removal complete"

cd $ROON_DIR

if [[ ! -d "RoonBridge" ]]; then
    declare -A file_dict
    file_dict[x86_64]=RoonBridge_linuxx64.tar.bz2
    file_dict[armv7l]=RoonBridge_linuxarmv7hf.tar.bz2
    file_dict[aarch64]=RoonBridge_linuxarmv8.tar.bz2
    ARCH=`uname -m`
    if [[ -n "${FORCE_ARCH}" ]]; then
        ARCH="${FORCE_ARCH}"
    fi
    FILENAME=${file_dict["${ARCH}"]}
    echo "We need file [$FILENAME] ..."
    if [ -f "/files/$FILENAME" ]; then
        echo "File [$FILENAME] is already available via /files mountpoint"
        cp /files/$FILENAME $ROON_DIR/
    else
        URL_DIR="https://download.roonlabs.net/builds/"
        if [[ -n "${BASE_URL}" ]]; then
            echo "Using custom BASE_URL = [${BASE_URL}] ..."
            URL_DIR="${BASE_URL}"
        fi
        echo "About to download [$URL_DIR/$FILENAME] ..."
        curl -O "$URL_DIR/$FILENAME"
        echo "Download complete"
    fi
    FILE="$ROON_DIR/$FILENAME"
    tar -xf $FILE
    echo "Installation terminated"
else
    echo "Installation already exists"
fi

echo "Start bridge"

cd $ROON_DIR/RoonBridge

./start.sh
