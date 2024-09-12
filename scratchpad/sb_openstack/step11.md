## Contract Testing - Provider Implementation

### Tools Used

1. Pact

### Steps

1. Use Pact to replay the consumers contract expectations, against the provider implementation.
   1. `make docker_stop_all`{{exec}} - Stop our docker containers, as one of the ports conflicts with the below test
   2. `make provider_project_pact_verification`{{exec}}
