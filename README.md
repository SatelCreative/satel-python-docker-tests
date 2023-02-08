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
    steps:
     - name: Local docker environment
        uses: SatelCreative/satel-local-docker-env@v1
        with:
          app-name: <APP-NAME> 
          registry: ${{ steps.registry-build-push.outputs.registry }}
          clean-branch-name: ${{ steps.registry-build-push.outputs.clean-branch-name }}
         # Below two are optional fields and depends on the webapp type
          validatecodeonce: true 
          multiple-server: true   
          work-dir: <WORK-DIR>

```        
- `host_name` is `self-hosted` or the name of server where the action runner is hosted, `cosmicray` for example
- `app-name` can be `st-pim` or `sb-pim` for example and it's optional
- `registry` & `clean-branch-name` parameter is set in a previous st
- `validatecodeonce` & `multiple-server` are optional, for most webapps, if there is just one server pass `validatecodeonce` as true and skip `multiple-server`.
   If the webapp has multiple server, for example `sb-pim`, pass `multiple-server` as `true` and skip `validatecodeonce`
- `work-dir`, where all the docker related files are located   
