## Write your first gRPC consumer test with Pact using the [pact-protobuf-plugin](https://github.com/pactflow/pact-protobuf-plugin)

### Prerequisites

- [pact-protobuf-plugin](https://github.com/pactflow/pact-protobuf-plugin)
- A Pact Library - We are using the [Pact-FFI](https://github.com/pact-foundation/pact-reference/tree/master/rust/pact_ffi#pact-ffi) in this example

#### gRPC

The following steps will use a script file to

- Download the Pact FFI Library
- Download the Pact CLI tools
  - Pact Ruby Standalone (to publish pact files to our Broker)
  - Pact Verifier CLI (to verify our pact files against our Provider)
  - Pact Plugin CLI to install our Pact Protobuf Plugin
- Download the Pact Protobuf Plugin

1. `cd ~/pact-ruby-ffi`{{exec}}
2. `make download_libs`{{exec}}
3. `make install_protobuf_plugin`{{exec}}

###  Write our tests

See file
1. `examples/area_calculator/spec/pactffi_create_plugin_pact_spec.rb`{{open}}

###  Run the tests

4. `make test_demo_gprc_pact`{{exec}}
5. `[ -f examples/area_calculator/pacts/grpc-consumer-ruby-area-calculator-provider.json  ] && echo "OK"`{{exec}}
6. `make show_demo_gprc_pact`{{exec}}