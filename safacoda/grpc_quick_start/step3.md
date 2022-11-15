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

1. `examples/area_calculator/spec/pactffi_create_plugin_pact_spec.rb`
5. Click the filename above to copy it.
6. Click somewhere in the `editor` tab
7. press `ctrl+p` or `command+p` to search for a file
8. Press `ctrl+v` or `command+v` to paste the filename and press enter

Take some time to study the Pact test. 

We are setting up the gRPC Pact interaction, and loading into it, the Protobuf definition `examples/area_calculator/proto/area_calculator.proto`

###  Run the tests

4. `make test_demo_gprc_pact`{{exec}}
5. `[ -f examples/area_calculator/pacts/grpc-consumer-ruby-area-calculator-provider.json  ] && echo "OK"`{{exec}}
6. `make show_demo_gprc_pact`{{exec}}


### Take a look at the files used in this example

1. `examples/area_calculator/spec/pactffi_create_plugin_pact_spec.rb`
2. `examples/area_calculator/area_calculator_consumer.rb`
3. `examples/area_calculator/proto/area_calculator.proto`
4. `examples/area_calculator/pacts/grpc-consumer-ruby-area-calculator-provider.json`
5. Click the filename above to copy it.
6. Click somewhere in the `editor` tab
7. press `ctrl+p` or `command+p` to search for a file
8.  Press `ctrl+v` or `command+v` to paste the filename and press enter