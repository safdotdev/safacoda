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
1. It will take a little while to download the Docker images for your Pact Broker, and Postgres database.
2. After a short while, a the new web interface will be available.
3. Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents.

## Publish our pacts to our broker

1. `export PACT_BROKER_USERNAME=pact_workshop`{{exec}}
2. `export PACT_BROKER_PASSWORD=pact_workshop`{{exec}}
3. `export PACT_BROKER_BASE_URL={{TRAFFIC_HOST1_8000}})`{{exec}}
4. `alias pact-broker=~/pact-ruby-ffi/pact/standalone/linux-x64-1.91.0/pact/bin/pact-broker`{{exec}}
5. `pact-broker publish pacts --consumer-app-version $(git rev-parse HEAD) --branch $(git rev-parse --abbrev-ref HEAD)`{{exec}}
6. Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents.

## Verify our running provider, and publish the results to the Broker.

1. `todo`{{exec}}
2. Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents.


## Tada

That is it for now, take some time to click around the codebase if you want otherwise catch us over at the [Pact Foundation Slack](http://slack.pact.io/)

1. `exit`{{exec}}