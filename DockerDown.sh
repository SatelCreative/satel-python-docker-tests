#!/bin/bash
APP_NAME=$1
REGISTRY=$2
CLEAN_BRANCH_NAME=$3

# Set registry and clean branch name as global variables
export REGISTRY=$REGISTRY
export CLEAN_BRANCH_NAME=$CLEAN_BRANCH_NAME 

echo "Docker down"
docker-compose -f docker-compose.yml -f docker-compose.pipeline.yml down