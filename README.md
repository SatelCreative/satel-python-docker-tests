# Satel Local Docker environment
This centralized GitHub action runs tests on local docker services

## Usage 
```yml
name: "Local docker environment"
on:
  pull_request:
    types:
      - opened
  push:
    tags:
      - "*"
    branches:
      - main  
    
    build-server:
    name: Build server
    needs: [generate-variables, build-client]
    runs-on: <host_name>
    steps:
     - name: Local docker environment
        uses: SatelCreative/satel-local-docker-env@v1
        with:
          app-name: st-pim     
          registry: ${{ steps.registry-build-push.outputs.registry }}
          clean-branch-name: ${{ steps.registry-build-push.outputs.clean_branch_name }}
          # below two are not required fields and depends on the webapp type
          validatecodeonce: true 
          multiple-server: true   

```        