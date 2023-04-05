# Satel Python Docker Tests
This centralized GitHub action runs tests on python app using docker services

## Usage 
```yml
name: Run tests
on: 
 <conditions-you-want-this-workflow-to-run-on>

  jobs:  
    code-validation:
    # HOST-NAME is self-hosted or the name of server where the action runner is hosted, cosmicray for example
    runs-on: <HOST-NAME>
    steps:
     - name: Local docker environment
        uses: SatelCreative/satel-local-docker-env@1.0.0
        with:
          # APP-NAME can be st-pim or sb-pim for example
          app-name: <APP-NAME> 
          registry: <REGISTRY-NAME>
          clean-branch-name: <CLEAN-BRANCH-NAME>
          # validatecodeonce & multiple-server are optional, for most webapps, if there is just one server pass validatecodeonce as    true and skip multiple-server  
          validatecodeonce: <BOOLEAN>
          multiple-server: <BOOLEAN>    
          fastapi-parameter: </PARAMETER>
          # WORK-DIR, where all the docker related files are located, optional field, default is root
          work-dir: <WORK-DIR>
          
```
   NOTE: If the webapp has multiple server, for example `sb-pim`, pass `multiple-server` as `true` and skip `validatecodeonce`
