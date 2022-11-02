## Get started with Pact FFI and Pact Plugins

1. `cd ~/pact-ruby-ffi`{{exec}} -< If you get stuck, click here!
2. `bundle install`{{exec}}
3. `./script/download-libs.sh`{{exec}} you will need to download the FFI library, in order to use it!
4. `rake spec`{{exec}} You can run the tests now
5. `cat "pacts/Consumer-Alice Service.json" | jq .`{{exec}}
6. `cat pacts/http-consumer-1-http-provider.json | jq .`{{exec}}
7. `cat pacts/http-consumer-2-http-provider.json | jq .`{{exec}}
8. `cat pacts/message-consumer-2-message-provider.json | jq .`{{exec}}
9. `cd examples/area_calculator && bundle install`{{exec}}
10. `cd ~/pact-ruby-ffi`{{exec}}
11. `pact/plugin/pact-plugin-cli -y install https://github.com/pactflow/pact-protobuf-plugin/releases/latest`{{exec}}
12. `rspec examples/area_calculator/spec/pactffi_create_plugin_pact_spec.rb`{{exec}}
13. `cat pacts/grpc-consumer-ruby-area-calculator-provider.json | jq .`{{exec}}
14. `rspec examples/area_calculator/area_calculator_provider.rb`{{exec}} in one tab
15. `rspec examples/area_calculator/area_calculator_consumer.rb`{{exec}} in the second tab
