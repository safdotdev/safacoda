## Get started with Pact FFI and Pact Plugins

1. `cd ~/pact-ruby-ffi`{{exec}} -< If you get stuck, click here!
2. `bundle install`{{exec}}
3. `./script/download-libs.sh`{{exec}} you will need to download the FFI library, in order to use it!
4. `[ -f "pact/ffi/linuxx8664/libpact_ffi.so" ] && echo "OK"`{{exec}}
1. `clear`{{exec}}

###  Run your tests

1. `rake spec`{{exec}} You can run the tests now
1. `clear`{{exec}}

### Check the http pact

1. `[ -f "pacts/Consumer-Alice Service.json"  ] && echo "OK"`{{exec}}
2. `cat "pacts/Consumer-Alice Service.json" | jq .`{{exec}}
1. `clear`{{exec}}

### Check another http pact

1. `[ -f pacts/http-consumer-1-http-provider.json ] && echo "OK"`{{exec}}
2. `cat pacts/http-consumer-1-http-provider.json | jq .`{{exec}}
1. `clear`{{exec}}
1. `clear`{{exec}}

### Check another http pact

2. `[ -f pacts/http-consumer-2-http-provider.json ] && echo "OK"`{{exec}}
3. `cat pacts/http-consumer-2-http-provider.json | jq .`{{exec}}
1. `clear`{{exec}}

### Check a message pact

1. `[ -f pacts/message-consumer-2-message-provider.json  ] && echo "OK"`{{exec}}
2. `cat pacts/message-consumer-2-message-provider.json | jq .`{{exec}}
1. `clear`{{exec}}

##  Lets use a Pact plugin, and see a Protobuf test in action

### Lets move to our gRPC demo project

1. `cd examples/area_calculator && bundle install`{{exec}}
1. `clear`{{exec}}

### Install the plugin

2. `cd ~/pact-ruby-ffi`{{exec}}
3. `pact/plugin/pact-plugin-cli -y install https://github.com/pactflow/pact-protobuf-plugin/releases/latest`{{exec}}
4. `[ -f ../.pact/plugins/protobuf-0.1.15/pact-plugin.json  ] && echo "OK"`{{exec}}
5. `cat ../.pact/plugins/protobuf-0.1.15/pact-plugin.json | jq .`{{exec}}
6. `ls ../.pact/plugins/protobuf-0.1.15`{{exec}}
1. `clear`{{exec}}

###  Run the tests

7. `rspec examples/area_calculator/spec/pactffi_create_plugin_pact_spec.rb`{{exec}}
1. `[ -f pacts/grpc-consumer-ruby-area-calculator-provider.json  ] && echo "OK"`{{exec}}
2. `cat pacts/grpc-consumer-ruby-area-calculator-provider.json | jq .`{{exec}}
1. `clear`{{exec}}

###  Check the plugin logs

3. `[ -f pacts/grpc-consumer-ruby-area-calculator-provider.json  ] && echo "OK"`{{exec}}
4. `cat ../.pact/plugins/protobuf-0.1.15/log/plugin.log.json.* | jq .`{{exec}}
1. `clear`{{exec}}

### Run the provider (in your first tab)

5. `ruby examples/area_calculator/area_calculator_provider.rb`{{exec}} in one tab

### Run the consumer (in your second tab)

1. `source /etc/profile.d/rvm.sh`{{exec}}
2. `cd ~/pact-ruby-ffi`{{exec}}
3. `ruby examples/area_calculator/area_calculator_consumer.rb`{{exec}}


## Tada

That is it for now, take some time to click around the codebase if you want otherwise catch us over at the [Pact Foundation Slack](http://slack.pact.io/)