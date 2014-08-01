#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

NEED_DIND=0
if [ ! -e /var/run/docker.sock ]; then
  NEED_DIND=1
fi

if $NEED_DIND; then
  DOCKER_READY=0
  dind &

  # wait for docker to be available
  ATTEMPTS=0
  while [ $ATTEMPTS -lt 10 ]; do
    docker version &> /dev/null
    if [ $? -eq 0 ]; then
      DOCKER_READY=1
      break
    fi

    let ATTEMPTS=ATTEMPTS+1
    sleep 1
  done

  if !$DOCKER_READY; then
    echo 'Docker-in-Docker daemon not accessible'
    exit 1
  fi
fi

TAG=$BUILD_TAG
if [ -n "$DOCKER_REGISTRY" ]; then
  TAG=$DOCKER_REGISTRY/$BUILD_TAG
fi

docker build --rm -t $TAG $DOCKER_CONTEXT_URL

if [ -n "$DOCKER_REGISTRY" ]; then
  docker push $TAG
fi

if $NEED_DIND; then
  kill -15 $(cat /var/run/docker.pid)
fi
