# Satel Local Docker environment
This centralized GitHub action runs tests on local docker services

## Usage 
```yml
name: Run tests
on:
  workflow_call:
    inputs:
      app-name:
        required: true
        type: string
      docker-tag-name:
        required: true
        type: string
      registry:
        required: true
        type: string
    secrets:
      DOCKER_REGISTRY_USER:
        required: true
      DOCKER_REGISTRY_PASS:
        required: true 

  jobs:  
    code-validation:
    needs: [set-variables] 
    # HOST-NAME is self-hosted or the name of server where the action runner is hosted, cosmicray for example
    runs-on: <HOST-NAME>
    steps:
     - name: Local docker environment
        uses: SatelCreative/satel-local-docker-env@1.0.0
        with:
          # APP-NAME can be st-pim or sb-pim for example
          app-name: <APP-NAME> 
          registry: ${{ inputs.registry }}
          clean-branch-name: ${{ inputs.docker-tag-name}}
          # validatecodeonce & multiple-server are optional, for most webapps, if there is just one server pass validatecodeonce as    true and skip multiple-server  
          validatecodeonce: <BOOLEAN>
          multiple-server: <BOOLEAN>      
          fastapi-parameter: '/pim'
          # WORK-DIR, where all the docker related files are located, optional field, if it's not root
          work-dir: <WORK-DIR>
          
```
   NOTE: If the webapp has multiple server, for example `sb-pim`, pass `multiple-server` as `true` and skip `validatecodeonce`
