## Get started with Pact FFI and Pact Plugins

1. `cd ~/pact-ruby-ffi`{{exec}} -< If you get stuck, click here!
2. `bundle install`{{exec}}
3. `./script/download-libs.sh`{{exec}} you will need to download the FFI library, in order to use it!

###  Run your tests

4. `rake spec`{{exec}} You can run the tests now

### Check the http pact

5. `cat "pacts/Consumer-Alice Service.json" | jq .`{{exec}}

### Check another http pact

6. `cat pacts/http-consumer-1-http-provider.json | jq .`{{exec}}

### Check another http pact

7. `cat pacts/http-consumer-2-http-provider.json | jq .`{{exec}}

### Check a message pact

8. `cat pacts/message-consumer-2-message-provider.json | jq .`{{exec}}

##  Lets use a Pact plugin, and see a Protobuf test in action

1. `cd examples/area_calculator && bundle install`{{exec}}
2. `cd ~/pact-ruby-ffi`{{exec}}
3. `pact/plugin/pact-plugin-cli -y install https://github.com/pactflow/pact-protobuf-plugin/releases/latest`{{exec}}
4. `ls ../.pact/plugins/protobuf-0.1.15`{{exec}}
5. `cat ../.pact/plugins/protobuf-0.1.15/pact-plugin.json | jq .`{{exec}}
6. `rspec examples/area_calculator/spec/pactffi_create_plugin_pact_spec.rb`{{exec}}
7. `cat pacts/grpc-consumer-ruby-area-calculator-provider.json | jq .`{{exec}}
8. `cat ../.pact/plugins/protobuf-0.1.15/log/plugin.log.json.* | jq .`{{exec}}
9. `ruby examples/area_calculator/area_calculator_provider.rb`{{exec}} in one tab

## In a second tab

1.  `source /etc/profile.d/rvm.sh`{{exec}}
2.  `cd ~/pact-ruby-ffi`{{exec}} 
3.  `ruby examples/area_calculator/area_calculator_consumer.rb`{{exec}} 
