#!/bin/bash

mkdir "$(pwd)/out" -p

docker build --privileged --pull -o out .