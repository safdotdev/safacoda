## Publish your consumer gRPC test to the Pact broker

### Prerequisites

- Pact Broker Application
- Postgres Database
- Pact Broker Credentials
- Pact Standalone CLI

## Publish our pacts to our broker

1. `export PACT_BROKER_USERNAME=pact`{{exec}}
1. `export PACT_BROKER_PASSWORD=pact`{{exec}}
1. `export PACT_BROKER_BASE_URL={{TRAFFIC_HOST1_8000}}`{{exec}}
1. `make publish_grpc_pact`{{exec}}

### The steps in detail

1. `export PACT_BROKER_USERNAME=pact`{{exec}}
1. `export PACT_BROKER_PASSWORD=pact`{{exec}}
1. `export PACT_BROKER_BASE_URL={{TRAFFIC_HOST1_8000}}`{{exec}}
1. `alias pact-broker=~/pact-ruby-ffi/pact/standalone/pact/bin/pact-broker`{{exec}}
1. `pact-broker publish examples/area_calculator/pacts --consumer-app-version $(git rev-parse HEAD) --branch $(git rev-parse --abbrev-ref HEAD)`{{exec}}
1. Click on the link in the terminal to to see the pact published in the Broker.
1. You can also open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents, you should see a pact file, without a verification (no green or red mark in the matrix).
