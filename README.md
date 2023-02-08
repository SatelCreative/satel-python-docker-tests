# Satel Local Docker environment
This centralized GitHub action runs tests on local docker services

## Usage 
```yml
name: "build and deploy webapp"
on:
  pull_request:
    types:
      - opened
  push:
    tags:
      - "*"
    branches:
      - main  

  jobs:  
    build-server:
    name: Build server
    needs: [generate-variables] 
    runs-on: <HOST-NAME>
    # HOST-NAME is self-hosted or the name of server where the action runner is hosted, cosmicray for example
    steps:
     - name: Local docker environment
        uses: SatelCreative/satel-local-docker-env@v1
        with:
          app-name: <APP-NAME> 
          # APP-NAME can be st-pim or sb-pim for example
          registry: ${{ steps.registry-build-push.outputs.registry }}
          clean-branch-name: ${{ steps.registry-build-push.outputs.clean-branch-name }}
          # registry & clean-branch-name parameter is set in a previous step
          validatecodeonce: <BOOLEAN>
          multiple-server: <BOOLEAN>  
          # validatecodeonce & multiple-server are optional, for most webapps, if there is just one server pass validatecodeonce as true and skip multiple-server  
          work-dir: <WORK-DIR>
          # WORK-DIR, where all the docker related files are located
```

   NOTE: If the webapp has multiple server, for example `sb-pim`, pass `multiple-server` as `true` and skip `validatecodeonce`
