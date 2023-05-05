# Satel Python Docker Tests
This centralized GitHub action runs tests on a python app using docker services

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
     - name: Validate code
        uses: SatelCreative/satel-local-python-tests@1.0.0
        with:
          # APP-NAME can be st-pim or sb-pim for example
          app-name: <APP-NAME> 
          registry: <REGISTRY-NAME>
          clean-branch-name: <CLEAN-BRANCH-NAME>  
          # WORK-DIR, where all the docker related files are located, optional field, default is root
          work-dir: <WORK-DIR>
          fastapi-parameter: </PARAMETER>
          container-name: <NAME_OF-WEBAPP-CONTAINER>
          
          
```