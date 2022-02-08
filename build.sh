#!/bin/bash

REPO="docker.io/jawnsy"
IMAGE_NAME="builder"
IMAGE_TAG="latest"

if [ "${EVENT_TYPE}" == "pull_request" ]; then
  IMAGE_TAG="pr-${EVENT_NUMBER}"
fi

IMAGE_REF="${REPO}/${IMAGE_NAME}:${IMAGE_TAG}"

docker build . --tag="$IMAGE_REF"

docker push --quiet "$IMAGE_REF"

echo
echo "IMAGE REF: ${IMAGE_REF}"
echo
echo "::set-output name=imageref::${IMAGE_REF}"
echo
