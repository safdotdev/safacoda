## Verify your gRPC provider application with Pact, using the local pact file, publishing results to the broker

### Prerequisites

- Pact Broker Application
- Pact Broker Credentials
- Pact Verifier CLI

## Verify our running provider, and publish results to the broker

We will utilise our Pact Broker, by publishing the results from a local verification. We will use the pact file we have locally.

Run `make verify_demo_gprc_publish_broker`{{exec}} to start the provider and run the tests

The steps in detail

1. `ruby examples/area_calculator/area_calculator_provider.rb &`{{exec}} This will start our provider, listening in a background process.
1. `pact/verifier/pact_verifier_cli -f examples/area_calculator/pacts/grpc-consumer-ruby-area-calculator-provider.json -p 37757 -l info --publish --provider-name area-calculator-provider --provider-version $(git rev-parse HEAD) --provider-branch $(git rev-parse --abbrev-ref HEAD)`{{exec}}
3. `ps -a | grep -e 'ruby' | awk '{print $1}' | xargs kill`{{exec}} Stop the provider
2. Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents, you can see a passing verification. If you stop the provider and run it again, you will observe a failing pact.

We only recommend publishing verification results from your CI system, so it is always best to use a read only user to retrieve the pacts, who doesn't have writes to publish verification results