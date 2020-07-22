#!/bin/bash
# LOGIN STEP REQUIRED: docker login --username=your_username docker.io
set -xe
REPO="alarconj/postgresql-logs"
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
GIT_COMMIT=$(git rev-parse HEAD)
VERSION=$(cat VERSION)
docker build -t $REPO:latest -t $REPO:$GIT_BRANCH -t $REPO:$GIT_COMMIT -t $REPO:$GIT_BRANCH-$VERSION -t $REPO:$GIT_BRANCH-$GIT_COMMIT --label "version=$VERSION" --build-arg revision=$GIT_COMMIT --build-arg version=$VERSION .

echo "Built: $GIT_COMMIT"

docker image push $REPO:latest
docker image push $REPO:$GIT_BRANCH 
docker image push $REPO:$GIT_COMMIT
docker image push $REPO:$GIT_BRANCH-$VERSION
docker image push $REPO:$GIT_BRANCH-$GIT_COMMIT

echo "Push: $GIT_COMMIT"
