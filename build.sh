#!/bin/bash

export TAG="alarconj/postgresql-logs:latest"

docker build -t $TAG ./

echo "Built: $TAG"
