#!/bin/bash

# error codes
# 2 Invalid base image

declare -A base_image_tags

base_image_tags[stable]=debian:stable-slim
base_image_tags[bookworm]=debian:bookworm-slim
base_image_tags[bullseye]=debian:bullseye-slim

declare -A local_tag
local_tag[stable]=local-stable
local_tag[bookworm]=local-bookworm
local_tag[bullseye]=local-bullseye

DEFAULT_BASE_IMAGE=stable
DEFAULT_TAG=local

tag=""
git_branch="$DEFAULT_GIT_VERSION"

while getopts b:t:p: flag
do
    case "${flag}" in
        b) base_image_tag=${OPTARG};;
        t) tag=${OPTARG};;
    esac
done

echo "base_image_tag: $base_image_tag";
echo "tag: $tag";

if [ -z "${base_image_tag}" ]; then
  base_image_tag=$DEFAULT_BASE_IMAGE
fi

selected_image_tag=${base_image_tags[$base_image_tag]}
if [ -z "${selected_image_tag}" ]; then
  echo "invalid base image ["${base_image_tag}"]"
  exit 2
fi

select_tag=${local_tag[$base_image_tag]}
if [[ -n "$select_tag" ]]; then
  tag=$select_tag
else
  tag=$DEFAULT_TAG
fi

echo "Base Image Tag: [$selected_image_tag]"
echo "Build Tag: [$tag]"

docker build . \
    --build-arg BASE_IMAGE=${selected_image_tag} \
    -t giof71/roon-bridge:$tag
