#!/bin/bash

echo "install bridge"

#https://download.roonlabs.net/builds/RoonBridge_linuxarmv8.tar.bz2
#https://download.roonlabs.net/builds/RoonBridge_linuxarmv7hf.tar.bz2
#https://download.roonlabs.net/builds/RoonBridge_linuxx64.tar.bz2

cd /roon

URL_DIR="https://download.roonlabs.net/builds/"

declare -A file_dict
file_dict[x86_64]=RoonBridge_linuxx64.tar.bz2
file_dict[armv7l]=RoonBridge_linuxarmv7hf.tar.bz2
file_dict[aarch64]=RoonBridge_linuxarmv8.tar.bz2

ARCH=`uname -m`

FILENAME=${file_dict["${ARCH}"]}
FILE="/roon/$FILENAME"

curl -O "$URL_DIR/$FILENAME"
tar -xf $FILE

echo "Installation terminated"