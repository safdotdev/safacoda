## Verify your gRPC provider application with Pact, using the published pact file, publishing results to the broker

### Prerequisites

- Pact Broker Application
- Pact Broker Credentials
- Pact Verifier CLI

# Lets fetch pacts from our broker instead.

We will utilise our Pact Broker, by publishing the results from a local verification. We will retrieve pact files from the Pact Broker, rather than providing a file directly.

We use [Consumer Version Selectors](https://docs.pact.io/pact_broker/advanced_topics/consumer_version_selectors) to determine the pacts to select.

Here we are using `{"matchingBranch":true}` to retrieve pacts, published to the same named branch, as our consumer. This is often used when delivering feature work. See the link above for full possible options.

1. Run `make verify_demo_gprc_fetch_broker`{{exec}} to start the provider and run the tests

### The steps in detail

1. `ruby examples/area_calculator/area_calculator_provider.rb &_pid=$!`{{exec}} This will start our provider, listening in a background process.
1. `pact/verifier/pact_verifier_cli -p 37757 -l info --publish --provider-name area-calculator-provider --provider-version $(git rev-parse HEAD) --provider-branch $(git rev-parse --abbrev-ref HEAD) --consumer-version-selectors {\"matchingBranch\":true}`{{exec}}
1. `kill $_pid`{{exec}} Stop the provider
1. Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents, you can see a passing verification, marked with green
1. If you stop the provider and run it again, you will observe a failing verification, marked with red

_Note:_ We only recommend publishing verification results from your CI system, so it is always best to use a read only user to retrieve the pacts, who doesn't have rights to publish verification results

### Recommended Selectors

These are the recommended selectors that will cover the majority of workflows.

- `{ "mainBranch": true }` - the latest version from the main branch of each consumer, as specified by the consumer's - `mainBranch property.
- `{ "branch": "<branch>" }` - the latest version from a particular branch of each consumer.
- `{ "deployedOrReleased": true }` - all the currently deployed and currently released and supported versions of each - `consumer.
- `{ "matchingBranch": true }` - the latest version from any branch of the consumer that has the same name as the current branch of the provider. Used for coordinated development between consumer and provider teams using matching feature branch names.
