## Get started with Pact FFI and Pact Plugins

1. `cd ~/pact-ruby-ffi`{{exec}} -< If you get stuck, click here!
2. `bundle install`{{exec}}
1. `./script/download-libs.sh`{{exec}} you will need to download the FFI library, in order to use it!
1. `[ -f "pact/ffi/linuxx8664/libpact_ffi.so" ] && echo "OK"`{{exec}}
1. `clear`{{exec}}

###  Run your tests

1. `rake spec`{{exec}} You can run the tests now
1. `clear`{{exec}}

### Check the http pact

1. `[ -f "pacts/Consumer-Alice Service.json"  ] && echo "OK"`{{exec}}
1. `cat "pacts/Consumer-Alice Service.json" | jq .`{{exec}}
1. `clear`{{exec}}

### Check another http pact

1. `[ -f pacts/http-consumer-1-http-provider.json ] && echo "OK"`{{exec}}
1. `cat pacts/http-consumer-1-http-provider.json | jq .`{{exec}}
1. `clear`{{exec}}

### Check another http pact

1. `[ -f pacts/http-consumer-2-http-provider.json ] && echo "OK"`{{exec}}
1. `cat pacts/http-consumer-2-http-provider.json | jq .`{{exec}}
1. `clear`{{exec}}

### Check a message pact

1. `[ -f pacts/message-consumer-2-message-provider.json  ] && echo "OK"`{{exec}}
1. `cat pacts/message-consumer-2-message-provider.json | jq .`{{exec}}
1. `clear`{{exec}}

##  Lets use a Pact plugin, and see a Protobuf test in action

### Lets move to our gRPC demo project

1. `cd examples/area_calculator && bundle install`{{exec}}
1. `clear`{{exec}}

### Install the plugin

1. `cd ~/pact-ruby-ffi`{{exec}}
1. `pact/plugin/pact-plugin-cli -y install https://github.com/pactflow/pact-protobuf-plugin/releases/latest`{{exec}}
1. `[ -f ../.pact/plugins/protobuf-0.1.15/pact-plugin.json  ] && echo "OK"`{{exec}}
1. `cat ../.pact/plugins/protobuf-0.1.15/pact-plugin.json | jq .`{{exec}}
1. `ls ../.pact/plugins/protobuf-0.1.15`{{exec}}
1. `clear`{{exec}}

###  Run the tests

7. `rspec examples/area_calculator/spec/pactffi_create_plugin_pact_spec.rb`{{exec}}
1. `[ -f pacts/grpc-consumer-ruby-area-calculator-provider.json  ] && echo "OK"`{{exec}}
2. `cat pacts/grpc-consumer-ruby-area-calculator-provider.json | jq .`{{exec}}
1. `clear`{{exec}}

###  Check the plugin logs

1. `[ -f pacts/grpc-consumer-ruby-area-calculator-provider.json  ] && echo "OK"`{{exec}}
1. `cat ../.pact/plugins/protobuf-0.1.15/log/plugin.log.json.* | jq .`{{exec}}
1. `clear`{{exec}}

### Run the provider (in your first tab)

1. `ruby examples/area_calculator/area_calculator_provider.rb`{{exec}} in one tab

### Run the consumer (in your second tab)

1. `source /etc/profile.d/rvm.sh`{{exec}}
1. `cd ~/pact-ruby-ffi`{{exec}}
1. `ruby examples/area_calculator/area_calculator_consumer.rb`{{exec}}

You should see the area result, switch back to tab 1, and you will see a log message from the provider stating it received the request, and calculated a result

## Lets verify our Provider with the Pact Verifier CLI

todo

## Lets get a Pact Broker

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
5. `pact-broker publish pacts --consumer-app-version $(git rev-parse HEAD) --branch $(git rev-parse --abbrev-ref HEAD)`{{exec}}
6. Click on the links to to see the individual pacts published in the Broker.

## Verify our running provider locally

ensure our provider is running `ruby examples/area_calculator/area_calculator_provider.rb`

1. `pact_verifier_cli -f pacts/grpc-consumer-ruby-area-calculator-provider.json -p 37757 -l info`{{exec}}
2. Tests should pass!
3. Stop the provider and run the tests again, the verification should correctly fail.
   
## Verify our running provider, and publish results to the broker

1. `pact_verifier_cli -f pacts/grpc-consumer-ruby-area-calculator-provider.json -p 37757 -l info --publish --provider-name area-calculator-provider --provider-version $(git rev-parse HEAD) --provider-branch $(git rev-parse --abbrev-ref HEAD)`{{exec}}
2. Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents, you can see a passing verification. If you stop the provider and run it again, you will observe a failing pact.

We only recommend publishing verification results from your CI system, so it is always best to use a read only user to retrieve the pacts, who doesn't have writes to publish verification results

## Tada

That is it for now, take some time to click around the codebase if you want otherwise catch us over at the [Pact Foundation Slack](http://slack.pact.io/)

1. `exit`{{exec}}


## Ruby FFI Plugin

1. `cd ~/pact-ruby-ffi`{{exec}}
1. `gem update bundler`{{exec}}
2. `make install`{{exec}}
3. `make download_libs`{{exec}}
4. `make test_message_pact`{{exec}}
5. `make show_message_pact`{{exec}}
6. `make test_pactffi_create_mock_server_for_pact`{{exec}}
7. `make show_pactffi_create_mock_server_for_pact`{{exec}}
8. `make test_pactffi_create_mock_server`{{exec}}
9. `make show_pactffi_create_mock_server`{{exec}}
10. `make publish_pacts`{{exec}}


## grpc_demo_protobuf_plugin

1. `cd ~/pact-ruby-ffi`{{exec}}
1. `gem update bundler`{{exec}}
2. `make install`{{exec}}
3. `make download_libs`{{exec}}
4. `make install_protobuf_plugin`{{exec}}
5. `make install_demo_grpc`{{exec}}
6. `make test_demo_gprc_pact`{{exec}}
7. `make show_demo_gprc_pact`{{exec}}
8. `make verify_demo_gprc_local`{{exec}}
9. `make publish_grpc_pact`{{exec}}
10. `make verify_demo_gprc_publish_broker`{{exec}}
11. `make verify_demo_gprc_fetch_broker`{{exec}}