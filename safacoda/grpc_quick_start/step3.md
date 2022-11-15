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

Make sure we are in the right directory

- `cd ~/pact-ruby-ffi`{{exec}}

Download the required libraries

- `make download_libs`{{exec}}

Download the Protobuf plugin, with the Pact Plugin CLI

- `make install_protobuf_plugin`{{exec}}

###  Write our tests

- `examples/area_calculator/spec/pactffi_create_plugin_pact_spec.rb`
  
1. Click the filename above to copy it.
2. Click somewhere in the `editor` tab
3. press `ctrl+p` or `command+p` to search for a file
4. Press `ctrl+v` or `command+v` to paste the filename and press enter

Take some time to study the Pact test.

We are setting up the gRPC Pact interaction, and loading into it, the Protobuf definition `examples/area_calculator/proto/area_calculator.proto`

###  Run the tests

1. `make test_demo_gprc_pact`{{exec}}
1. `make show_demo_gprc_pact`{{exec}}

### Take a look at the files used in this step

- `examples/area_calculator/spec/pactffi_create_plugin_pact_spec.rb`
- `examples/area_calculator/area_calculator_consumer.rb`
- `examples/area_calculator/proto/area_calculator.proto`
- `examples/area_calculator/pacts/grpc-consumer-ruby-area-calculator-provider.json`

1. Click the filename above to copy it.
1. Click somewhere in the `editor` tab
1. press `ctrl+p` or `command+p` to search for a file
1. Press `ctrl+v` or `command+v` to paste the filename and press enter
