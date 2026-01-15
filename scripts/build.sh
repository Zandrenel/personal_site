#!/bin/bash
o
PORT=$1
MODE=$2

docker build --pull --no-cache ./ -t swi-site --build-arg PORT=${PORT:-3030} --build-arg MODE=${MODE:-dev}
