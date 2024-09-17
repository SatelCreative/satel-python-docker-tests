#!/bin/bash

# Set registry and clean branch name as global variables
export REGISTRY=$REGISTRY
export CLEAN_BRANCH_NAME=$CLEAN_BRANCH_NAME 

if [[ -n $WORK_DIR ]] 
then
    echo "WORK_DIR ${WORK_DIR}"
    cd $WORK_DIR
fi  

echo "Docker down"
docker compose -f docker-compose.yml -f docker-compose.pipeline.yml down
