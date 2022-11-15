## Get started with Pact FFI and Pact Plugins

### Lets move to our gRPC demo project

1. `cd ~/pact-ruby-ffi`{{exec}}

### Run the provider (in your first tab)

1. `make install_demo_grpc`{{exec}} Install our product dependencies
1. `ruby examples/area_calculator/area_calculator_provider.rb &`{{exec}} This will start our provider, listening in a background process.
2. `ruby examples/area_calculator/area_calculator_consumer_run.rb`{{exec}} We can now run our tests

You should see the area result, and you will see a log message from the provider stating it received the request, and calculated a result

1. `ps -a | grep -e 'area_calculator_provider' | awk '{print $1}' | xargs kill`{{exec}} Lets close down our running provider.

##  Lets use a Pact plugin, and see a Protobuf test in action

### Install the plugin

1. `cd ~/pact-ruby-ffi`{{exec}}
2. `make download_libs`{{exec}}
3. `make install_protobuf_plugin`{{exec}}

###  Run the tests

4. `make test_demo_gprc_pact`{{exec}}
5. `make show_demo_gprc_pact`{{exec}}

###  Check the output pact file

1. `[ -f examples/area_calculator/pacts/grpc-consumer-ruby-area-calculator-provider.json  ] && echo "OK"`{{exec}}
1. `cat examples/area_calculator/pacts/grpc-consumer-ruby-area-calculator-provider.json  | jq .`{{exec}}

## Verify our running provider locally

This command will start our provider, and then run the Pact Verifier CLI against the running provider and then shut it down.

6. `make verify_demo_gprc_local`{{exec}}

The steps in detail.

1. We ensure our provider is running `ruby examples/area_calculator/area_calculator_provider.rb &`{{exec}}
1. `pact/verifier/pact_verifier_cli -f examples/area_calculator/pacts/grpc-consumer-ruby-area-calculator-provider.json -p 37757 -l info`{{exec}}
2. Tests should pass!
3. `ps -a | grep -e 'ruby' | awk '{print $1}' | xargs kill`{{exec}} Stop the provider
1. `pact/verifier/pact_verifier_cli -f examples/area_calculator/pacts/grpc-consumer-ruby-area-calculator-provider.json -p 37757 -l info`{{exec}} Run the tests again, the verification should correctly fail.

## Lets get a Pact Broker

Now we have a passing test locally on the consumer side, and we have verified it on the provider side, we should now publish these to a Pact Broker to get the full benefits of contract testing.

1. `curl https://rebrand.ly/getpact -Lso - | bash -s -- broker deploy mybroker 8000`{{exec}}
2. It will take a little while to download the Docker images for your Pact Broker, and Postgres database.
3. After a short while, a the new web interface will be available.
4. Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents.
5. You can check the Docker logs for the Pact Broker, `docker logs mybroker_pact_broker_1`
6. Restart the container if there was any issues `docker restart mybroker_pact_broker_1`{{exec}}

## Publish our pacts to our broker

1. `export PACT_BROKER_USERNAME=pact`{{exec}}
2. `export PACT_BROKER_PASSWORD=pact`{{exec}}
3. `export PACT_BROKER_BASE_URL={{TRAFFIC_HOST1_8000}}`{{exec}}
4. `alias pact-broker=~/pact-ruby-ffi/pact/standalone/linux-x64-1.91.0/pact/bin/pact-broker`{{exec}}
5. `pact-broker publish examples/area_calculator/pacts --consumer-app-version $(git rev-parse HEAD) --branch $(git rev-parse --abbrev-ref HEAD)`{{exec}} or `make publish_grpc_pact`{{exec}}
6. Click on the links to to see the individual pacts published in the Broker.

## Verify our running provider, and publish results to the broker

We will utilise our Pact Broker, by publishing the results from a local verification. We will use the pact file we have locally.

1. `pact_verifier_cli -f examples/area_calculator/pacts/grpc-consumer-ruby-area-calculator-provider.json -p 37757 -l info --publish --provider-name area-calculator-provider --provider-version $(git rev-parse HEAD) --provider-branch $(git rev-parse --abbrev-ref HEAD)`{{exec}} or `make verify_demo_gprc_publish_broker`{{exec}} to start the provider and run the tests
2. Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents, you can see a passing verification. If you stop the provider and run it again, you will observe a failing pact.

We only recommend publishing verification results from your CI system, so it is always best to use a read only user to retrieve the pacts, who doesn't have writes to publish verification results

## Verify our running provider, and publish results to the broker

We will utilise our Pact Broker, by publishing the results from a local verification. We will retrieve pact files from the Pact Broker, rather than providing a file directly. 


1. `pact_verifier_cli -p 37757 -l info --publish --provider-name area-calculator-provider --provider-version $(git rev-parse HEAD) --provider-branch $(git rev-parse --abbrev-ref HEAD) --consumer-version-selectors {\"matchingBranch\":true}"`{{exec}} or `make verify_demo_gprc_fetch_broker`{{exec}} to start the provider and run the tests
2. Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents, you can see a passing verification. If you stop the provider and run it again, you will observe a failing pact.

We only recommend publishing verification results from your CI system, so it is always best to use a read only user to retrieve the pacts, who doesn't have writes to publish verification results

## Tada

That is it for now, take some time to click around the codebase if you want otherwise catch us over at the [Pact Foundation Slack](http://slack.pact.io/)

1. `exit`{{exec}}