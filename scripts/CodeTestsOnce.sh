#!/bin/bash

echo "App health check"  # Check to see if the app container is running or not
sleep 5
docker-compose exec -T webapp python -c "import requests; requests.get('http://localhost:8000/health')" || exit 1

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