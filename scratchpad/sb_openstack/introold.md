## Workshop Prerequisites

- Nothing! Just you and a bit of time

## Goals

See how far we can get with SmartBears Open Source tools, from an OpenAPI definition.

We _might_ leverage some other Open Source tools along the way, after all, we are all standing on the shoulders of Giants!

1. Download our SmartBear OpenStack Helper
   1. <https://gist.github.com/YOU54F/963b15ce7b71f5000b248e7401755f4f>
   2. `https://gist.githubusercontent.com/YOU54F/963b15ce7b71f5000b248e7401755f4f/raw`
2. Download a reference OpenAPI Specification - <https://swagger.io/resources/open-api/>
3. Run Swagger-UI via Docker
   1. <https://swagger.io/tools/swagger-ui/>
   2. Available for with a free account at <https://swagger.io/tools/swaggerhub/>
4. Run the New Swagger-Editor via Docker
   1. <https://swagger.io/tools/swagger-editor/>
   2. <https://editor.swagger.io/>
5. Run the Old Swagger-Editor via Docker
   1. <https://swagger.io/tools/swagger-editor/>
   2. <https://editor-next.swagger.io/>
6. Get Swagger Codegen CLI
   1. <https://swagger.io/tools/swagger-codegen/>
7. Download a Swagger Codegen fork with custom templates
8. Generate a Provider Codebase from our OpenAPI Specification
9. Use a helper tool called [OpenAPI2SoapUI](https://github.com/apiaddicts/openapi2soapui), that will allow us to convert our OpenAPI Specification into a SoapUI/ReadyAPI compliant file
    1. Build openapi2soapui
    2. Run openapi2soapui
    3. Convert our OpenAPI  
10. Run our SoapUI project via Docker
    1. <https://www.soapui.org/docs/test-automation/running-in-docker/>
11. Generate a Consumer Codebase from our OpenAPI Specification with Pact tests
    1. <http://pact.io/>

## Welcome to SmartBear OpenStack

- `curl -Ls https://gist.githubusercontent.com/YOU54F/963b15ce7b71f5000b248e7401755f4f/raw -o Makefile`{exec}
- `mkdir -p openapi`{{exec}}                        
- `make get_oas`{{exec}}                        
  - Downloads a reference OpenAPI specification
- `make get_swagger_editor`{{exec}}             
  - Downloads the swaggerapi/swagger-editor:next-v5 Docker image
- `make run_swagger_editor`{{exec}}            
  - Runs the swaggerapi/swagger-editor:next-v5 Docker image <https://github.com/swagger-api/swagger-editor/tree/next#docker> <https://github.com/swagger-api/swagger-editor/issues/3270>
  - Open the [Swagger Editor]({{TRAFFIC_HOST1_8081}}) and check it out
- `make get_swagger_editor_legacy`{{exec}}      
  - Downloads the swaggerapi/swagger-editor Docker image
- `make run_swagger_editor_legacy`{{exec}}      
  - Runs the swaggerapi/swagger-editor Docker image <https://github.com/swagger-api/swagger-editor#running-the-image-from-dockerhub>
  - Open the [Swagger Editor]({{TRAFFIC_HOST1_8082}}) and check it out
- `make run_swagger_ui`{{exec}}                 
  - Runs the swaggerapi/swagger-ui Docker image <https://github.com/swagger-api/swagger-ui/blob/master/docs/usage/configuration.md#docker>
- `make get_swagger_ui`{{exec}}                 
  - Downloads the swaggerapi/swagger-ui Docker image
  - Open the [Swagger Editor]({{TRAFFIC_HOST1_8083}}) and check it out
- `make get_provider_project`{{exec}}           
  - Downloads the pactflow/example-bi-directional-provider-soapui repository
- `make install_provider_project`{{exec}}       
  - Installs the pactflow/example-bi-directional-provider-soapui project
- `make run_soap_ui`{{exec}}                   
  - Runs a SoapUI test suite in Docker
- `provider_start_test_stop`{{exec}}      
  - Runs the provider project and tests with SoapUI
- `make run_provider_project`{{exec}}           
  - Runs the provider project in a background process and echos the PID
- `make install_typescript_fetch_pact`{{exec}}  
  - Install the templated project
- `make test_typescript_fetch_pact`{{exec}}     
  - Test the templated project with Pact
- `make git_ignore`{{exec}}                    
  - Creates a tailored .gitignore file
