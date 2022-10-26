#!/bin/bash
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


# echo "Docker down"
# docker-compose -f docker-compose.yml -f docker-compose.pipeline.yml down

