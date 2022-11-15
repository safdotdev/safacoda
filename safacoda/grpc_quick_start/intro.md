## Workshop Prerequisites

- Nothing! Just you and a bit of time

## Goals

Create a simple gRPC application, in Ruby, and test with Pact using the [pact-protobuf-plugin](https://github.com/pactflow/pact-protobuf-plugin) to showcase Pact's multi-protocol approach with the [pact-plugin](https://github.com/pact-foundation/pact-plugins) eco-system

You will:

1. Learn about the basics of gRPC
1. Run your first gRPC consumer and provider in Ruby, it will be a simple Area Calculator
1. Write your first gRPC consumer test with Pact using the [pact-protobuf-plugin](https://github.com/pactflow/pact-protobuf-plugin) which will generate a pact file.
1. Verify your gRPC provider application with Pact, locally
1. Setup a locally running Pact Broker
1. Publish your consumer gRPC test to the Pact broker
1. Verify your gRPC provider application with Pact, using the local pact file, publishing results to the broker
1. Verify your gRPC provider application with Pact, using the published pact file, publishing results to the broker


Install our Protobuf Plugin

- `~/pact-plugins/scripts/install-plugin-cli.sh`{{exec}}
- `~/bin/pact-plugin-cli -y install https://github.com/pactflow/pact-protobuf-plugin/releases/latest`{{exec}}

Install the Pact Verifier

- `~/pact-plugins/scripts/install-verifier-cli.sh `{{exec}}


Install the FFI libraries

- `go install github.com/pact-foundation/pact-go/v2@2.x.x`{{exec}}
- `$HOME/go/bin/pact-go -l DEBUG install`{{exec}}
- `sudo chmod 644 /usr/local/lib/libpact_ffi.so`{{exec}}
- `ls -la /usr/local/lib/`{{exec}}


Run the Consumer Go Tests
  
- `cd ~/pact-plugins/examples/gRPC/area_calculator/`{{exec}}
- `cd consumer-go`{{exec}}
- `go test -c`{{exec}}
- `pact_do_not_track=true LOG_LEVEL=trace ./consumer.test`{{exec}}


- ``{{exec}}
- ``{{exec}}
- ``{{exec}}
- ``{{exec}}
- ``{{exec}}
- ``{{exec}}