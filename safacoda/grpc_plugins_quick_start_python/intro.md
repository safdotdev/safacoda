## Workshop Prerequisites

- Nothing! Just you and a bit of time

## Goals

Create a simple gRPC application, in Python, and test with Pact using the [pact-protobuf-plugin](https://github.com/pactflow/pact-protobuf-plugin) to showcase Pact's multi-protocol approach with the [pact-plugin](https://github.com/pact-foundation/pact-plugins) eco-system

You will:

1. Learn about the basics of gRPC
1. Run your first gRPC consumer and provider in Python, it will be a simple Area Calculator
1. Write your first gRPC consumer test with Pact using the [pact-protobuf-plugin](https://github.com/pactflow/pact-protobuf-plugin) which will generate a pact file.
1. Verify your gRPC provider application with Pact, locally
1. Setup a locally running Pact Broker
1. Publish your consumer gRPC test to the Pact broker
1. Verify your gRPC provider application with Pact, using the published pact file, publishing results to the broker

## Temp steps to test

### Setup

- `python -m pip install --upgrade pip`{{exec}}
- `mkdir pact`{{exec}}
- `make setup`{{exec}}
- `make install`{{exec}}
- `make grpc_install`{{exec}}

### Run Tests

- `make run_hello_ffi`{{exec}}
- `make run_pact_http`{{exec}}
- `make run_pact_message_v3`{{exec}}
- `make run_pact_plugin_grpc_v4`{{exec}}
- `make run_hello_ffi`{{exec}}
- `make run_hello_ffi`{{exec}}
- `make pacts_show`{{exec}}

### View Pacts

- `cat "pacts/Consumer-Alice Service.json" | jq .`{{exec}}
- `cat "pacts/http-consumer-1-http-provider.json" | jq .`{{exec}}
- `cat "pacts/http-consumer-http-provider.json" | jq .`{{exec}}
- `cat "pacts/message-consumer-2-message-provider.json" | jq .`{{exec}}
- `cat "pacts/grpc-consumer-python-area-calculator-provider.json" | jq .`{{exec}}
- `"pacts/Consumer-Alice Service.json"`{{open}}
- `"pacts/http-consumer-1-http-provider.json"`{{open}}
- `"pacts/http-consumer-http-provider.json"`{{open}}
- `"pacts/message-consumer-2-message-provider.json"`{{open}}
- `"pacts/grpc-consumer-python-area-calculator-provider.json"`{{open}}

### Verify Provider locally, using pact from local file system

- `make grpc_run_provider & export PID=$!`{{exec}}
- `pact/verifier/pact_verifier_cli -f pacts/grpc-consumer-python-area-calculator-provider.json -p 37757 -l info`{{exec}}
- `kill $PID`{{exec}}

### Get a Broker

- `curl https://rebrand.ly/getpact -Lso - | bash -s -- broker deploy mybroker 8000`{{exec}}
- Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents.
- `export PACT_BROKER_BASE_URL={{TRAFFIC_HOST1_8000}}`{{exec}}

### Upload Pacts

- `alias pact-broker=~/pact-python-ffi/pact/bin/pact/bin/pact-broker`{{exec}}
- `pact-broker publish pacts --consumer-app-version $(git rev-parse HEAD) --branch $(git rev-parse --abbrev-ref HEAD)`{{exec}}

### Verify Provider locally, retrieving pacts from Broker and publish results

- `make grpc_run_provider & export PID=$!`{{exec}}
- `pact/verifier/pact_verifier_cli -p 37757 -l info --publish --provider-name area-calculator-provider --provider-version $(git rev-parse HEAD) --provider-branch $(git rev-parse --abbrev-ref HEAD) --consumer-version-selectors {\"matchingBranch\":true}`{{exec}}
- `kill $PID`{{exec}}