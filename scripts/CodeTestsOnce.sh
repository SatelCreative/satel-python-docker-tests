#!/bin/bash

APP_NAME=$1
CLEAN_BRANCH_NAME=$2

echo "App health check"  # Check to see if the app container is running or not
sleep 5
docker-compose exec -T webapp python -c "import requests; requests.get('http://localhost:8000/health')" || exit 1

echo "Openapi PR link"
docker-compose exec -T webapp python -c "import requests; f=open('${APP_NAME}_${CLEAN_BRANCH_NAME}_openapi.json','w',encoding = 'utf-8'); f.write(requests.get('http://localhost:8000/openapi.json').text);f.close()"
# add condition for beast as the work dir is different and not possible to change
# def runner_dir = (NODE_NAME == 'thebeast')? "/home/jenkins":"/var/lib/jenkins"  
# sh [ -d "${runner_dir}/samba/${pipelineParams.app_name}" ] || mkdir "${runner_dir}/samba/${pipelineParams.app_name}"
docker cp "$(docker-compose ps -q webapp)":/python/app/${APP_NAME}_${CLEAN_BRANCH_NAME}_openapi.json /var/lib/jenkins/samba/${APP_NAME}/${CLEAN_BRANCH_NAME}_openapi.json

echo "Clean up old reports" 
rm -f unittesting.xml coverage.xml typing.xml

echo "Code tests" 
## Catch the exit codes so we don't exit the whole script before we are done.
## Typing, linting, formatting check & unit and integration testing
docker-compose exec -T webapp validatecodeonce; STATUS1=$?
docker cp "$(docker-compose ps -q webapp)":/python/reports/typing.xml typing.xml
docker cp "$(docker-compose ps -q webapp)":/python/reports/unittesting.xml unittesting.xml
docker cp "$(docker-compose ps -q webapp)":/python/reports/coverage.xml coverage.xml
## Return the status code
TOTAL=$((STATUS1))

exit $TOTAL