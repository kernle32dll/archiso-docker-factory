#!/bin/bash

mkdir "$(pwd)/out" -p

docker run -it \
  --mount type=bind,source="$(pwd)"/build-iso.sh,target=/build-iso.sh,readonly \
  --mount type=bind,source="$(pwd)"/out,target=/out \
  --privileged \
  archlinux:latest \
  /build-iso.sh
