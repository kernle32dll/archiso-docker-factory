#!/bin/bash

mkdir "$(pwd)/out" -p

docker pull archlinux:latest

docker run -it \
  -e ISO_USER="$(id -u ${USER})" \
  -e ISO_GROUP="$(id -g ${USER})" \
  --mount type=bind,source="$(pwd)"/build-iso.sh,target=/build-iso.sh,readonly \
  --mount type=bind,source="$(pwd)"/out,target=/out \
  --privileged \
  archlinux:latest \
  /build-iso.sh
