#!/bin/bash
#At the moment this is for sb-pim only
# APP_TYPE=$1 TODO, replace typing.xml with this 
# TODO : remove hard coded container "pim_api" 


if [[ -n $WORK_DIR ]] 
then
    echo "WORK_DIR ${WORK_DIR}"
    cd $WORK_DIR
fi  

echo "App health check"  # Check to see if the app container is running or not
sleep 5
docker-compose exec -T pim_api python -c "import requests; requests.get('http://localhost:8000/health')" || exit 1
echo ${CLEAN_BRANCH_NAME}
echo "Openapi link" # copy openapi files to samba mount 
docker-compose exec -T pim_api python -c "import requests; f=open('${CLEAN_BRANCH_NAME}_openapi.json','w',encoding = 'utf-8'); f.write(requests.get('http://localhost:8000/openapi.json').text);f.close()"
cat docker-compose exec -T pim_api python /python/app/${CLEAN_BRANCH_NAME}_openapi.json
[ -d "/mnt/samba/${APP_NAME}" ] || mkdir -p "/mnt/samba/${APP_NAME}"
docker cp "$(docker-compose ps -q pim_api)":"/python/app/${CLEAN_BRANCH_NAME}_openapi.json" "/mnt/samba/${APP_NAME}/${CLEAN_BRANCH_NAME}_openapi.json"


echo "Clean up old reports" 
rm -f unittesting.xml coverage.xml typing-server.xml typing-integrations.xml

echo "Code tests" 
## Catch the exit codes so we don't exit the whole script before we are done.
## Typing, linting, formatting check & unit and integration testing
docker-compose ps
#docker-compose exec -T pim_api flake8; STATUS1=$?
docker-compose exec -T pim_api validatecodeonce; STATUS1=$?

TOTAL=$((STATUS1))
exit $TOTAL
