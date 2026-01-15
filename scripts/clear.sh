#!/bin/bash

echo "Starting Clear all running containers with the swi-site tag"
# Stop
echo "Try to stop all"
docker ps -a | grep swi-site | awk '{print $1}' | xargs docker stop

# Extra cleanup
echo "Try to rm all"
docker ps -a | grep swi-site | awk '{print $1}' | xargs docker rm
