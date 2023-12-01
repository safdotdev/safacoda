## Functional Testing - Provider Mock Implementation

Create functional tests for SoapUI, driven from the OpenAPI Specification.

Test these against our mock provider (provided by Prism), in order to verify the test suite / mock implementation, and prepare for verifying our provider codebase once implemented.

### Tools Used

1. SoapUI
   1. OpenApi2SoapUI
2. Stoplight Prism

### Steps

1. SoapUI
   1. `make openapi2soapui_fetch`{{exec}}
   2. `make openapi2soapui_build`{{exec}}
   3. `make openapi2soapui_generate_project`{{exec}}
   4. `make provider_mock_prism`{{exec}} - Run our Mock Provider
   5. In a second terminal `make soapui_run`{{exec}} in terminal 2
      1. Don't forget to change directory into the `cd openstack`{{exec}} beforehand in the new terminal
   6. Press `ctrl + c` to close the mock running in terminal 1
