## Client Code Generation & Contract Testing

### Tools Used

1. Swagger CodeGen
2. Pact
3. Swagger-Mock-Validator

### Steps

1. Fetch and build the Swagger CodeGen Project
   1. `make swagger_codegen_cli_fetch`{{exec}}
   2. `make swagger_codegen_generators_fetch`{{exec}}
   3. `make swagger_codegen_generators_build`{{exec}}
2. Generate the consumer template
   1. `make swagger_codegen_generators_generate`{{exec}}
   2. `make consumer_project_install`{{exec}}
3. Test the consumer project utilising Pact
   1. `make consumer_project_test`{{exec}}
4. Verify Pact's generated Consumer contracts against the OpenAPI
   1. `make consumer_project_verify_pact_openapi`{{exec}}