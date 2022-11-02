# Satel Webapp Testing
This centralized GitHub actions runs tests on webapp's docker services

## Usage 
```yml
name: "Code tests"
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
    - name: Code tests
        uses:  SatelCreative/satel-webapp-testing@feature/webapp-deployment-shell
```        