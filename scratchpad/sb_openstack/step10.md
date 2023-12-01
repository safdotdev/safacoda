## Functional Testing - Provider Implementation

### Tools Used

1. SoapUI

### Steps

1. Download a pre-prepared Provider implementation and try it out
   1. `make provider_project_fetch`{{exec}}
   2. `make provider_project_install`{{exec}}
   3. `make provider_project_run`{{exec}}
   4. `curl localhost:3001/products`{{exec}}
2. With the provider still running, run our SoapUI tests
   1. `make provider_project_run`{{exec}} in terminal 1
   2. `make soapui_run`{{exec}} in terminal 2
3. Start the server and test, all in one, omitting the need for two terminals
   1. `make provider_start_test_stop`{{exec}}
