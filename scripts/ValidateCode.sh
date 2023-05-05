#!/bin/bash

if [[ -n $WORK_DIR ]] 
then
    echo "WORK_DIR ${WORK_DIR}"
    cd $WORK_DIR
fi  

echo "App health check"  # Check to see if the app container is running or not
sleep 5
docker-compose exec -T ${CONTAINER_NAME} python -c "import requests; requests.get('http://localhost:8000/health')" || exit 1

echo "Openapi link" # copy openapi files to samba mount 
docker-compose exec -T ${CONTAINER_NAME} python -c "import requests; f=open('${CLEAN_BRANCH_NAME}_openapi.json','w',encoding = 'utf-8'); f.write(requests.get('http://localhost:8000${FAST_PARA}/openapi.json').text);f.close()"
[ -d "/mnt/samba/${APP_NAME}" ] || mkdir -p "/mnt/samba/${APP_NAME}"
docker cp "$(docker-compose ps -q ${CONTAINER_NAME})":"/python/app/${CLEAN_BRANCH_NAME}_openapi.json" "/mnt/samba/${APP_NAME}/${CLEAN_BRANCH_NAME}_openapi.json"

echo "Clean up old reports" 
rm -f unittesting.xml coverage.xml typing.xml typing-server.xml typing-integrations.xml

echo "Code tests" 
## Catch the exit codes so we don't exit the whole script before we are done.
## Typing, linting, formatting check & unit and integration testing
if [[ $CONTAINER_NAME != "webapp" ]]; then
    echo "flake8 tests" #TODO: remove the if else block once the errors on sb-pim are fixed
    docker-compose exec -T ${CONTAINER_NAME} flake8; STATUS1=$?    # For Sb-pim only
    docker cp "$(docker-compose ps -q ${CONTAINER_NAME})":/python/reports/typing-server.xml typing-server.xml
    docker cp "$(docker-compose ps -q ${CONTAINER_NAME})":/python/reports/typing-integrations.xml typing-integrations.xml
    
else
    docker-compose exec -T ${CONTAINER_NAME} validatecodeonce; STATUS1=$?
    docker cp "$(docker-compose ps -q ${CONTAINER_NAME})":/python/reports/typing.xml typing.xml
fi

docker cp "$(docker-compose ps -q ${CONTAINER_NAME})":/python/reports/unittesting.xml unittesting.xml
docker cp "$(docker-compose ps -q ${CONTAINER_NAME})":/python/reports/coverage.xml coverage.xml

## Return the status code
TOTAL=$((STATUS1))
exit $TOTAL
