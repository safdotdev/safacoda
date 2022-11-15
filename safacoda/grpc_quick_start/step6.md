## Publish your consumer gRPC test to the Pact broker

### Prerequisites

- Pact Broker Application
- Postgres Database
- Pact Broker Credentials
- Pact Standalone CLI

## Publish our pacts to our broker

1. `export PACT_BROKER_USERNAME=pact`{{exec}}
2. `export PACT_BROKER_PASSWORD=pact`{{exec}}
3. `export PACT_BROKER_BASE_URL={{TRAFFIC_HOST1_8000}}`{{exec}}
4. `alias pact-broker=~/pact-ruby-ffi/pact/standalone/pact/bin/pact-broker`{{exec}}
5. `pact-broker publish examples/area_calculator/pacts --consumer-app-version $(git rev-parse HEAD) --branch $(git rev-parse --abbrev-ref HEAD)`{{exec}} or `make publish_grpc_pact`{{exec}}
6. Click on the links to to see the individual pacts published in the Broker.