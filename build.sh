#!/bin/bash
# docker login --username=your_username --email=name@email.com docker.io
REPO="alarconj/postgresql-logs"
COMMIT=$(git rev-parse --short=7 HEAD)
docker build -t $REPO:latest ./

echo "Built: $COMMIT"

docker tag $REPO:latest $REPO:$COMMIT
docker image push $REPO:$COMMIT
docker image push $REPO:latest

echo "Push: $COMMIT"
