#!/bin/bash

REPOSITORY="docker.io/jawnsy"
IMAGE_NAME="builder"
IMAGE_TAG="latest"

if [ "${EVENT_TYPE}" == "pull_request" ]; then
  IMAGE_TAG="pr-${EVENT_NUMBER}"
fi

IMAGE_REF="${REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"

docker build . --tag="$IMAGE_REF"

docker push "$IMAGE_REF"

echo "::set-output name=image-ref::${IMAGE_REF}"
