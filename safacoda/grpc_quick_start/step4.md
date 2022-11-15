## Verify your gRPC provider application with Pact, locally

### Prerequisites

- Pact Verifier CLI

## Verify our running provider locally

This command will start our provider, and then run the Pact Verifier CLI against the running provider and then shut it down.

- `make verify_demo_gprc_local`{{exec}}

### The steps in detail

1. We ensure our provider is running `ruby examples/area_calculator/area_calculator_provider.rb &_pid=$!`{{exec}}
1. `pact/verifier/pact_verifier_cli -f examples/area_calculator/pacts/grpc-consumer-ruby-area-calculator-provider.json -p 37757 -l info`{{exec}}
1. Tests should pass!
1. `kill $_pid`{{exec}}
1. `pact/verifier/pact_verifier_cli -f examples/area_calculator/pacts/grpc-consumer-ruby-area-calculator-provider.json -p 37757 -l info`{{exec}} Run the tests again, the verification should correctly fail.