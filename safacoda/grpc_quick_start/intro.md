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


Install the FFI libraries - We will use the Pact-Go's helper function, to install the right version for our platform, you can download them directly from the [pact-reference release page](https://github.com/pact-foundation/pact-reference/releases/tag/libpact_ffi-v0.3.14)

- `go install github.com/pact-foundation/pact-go/v2@2.x.x`{{exec}}
- `$HOME/go/bin/pact-go -l DEBUG install`{{exec}}
- `sudo chmod 644 /usr/local/lib/libpact_ffi.so`{{exec}}
- `ls -la /usr/local/lib/`{{exec}}


Start your tests from here!
  
- `cd ~/pact-plugins/examples/gRPC/area_calculator/`{{exec}}


## Consumers

### JVM

```sh
cd ~/pact-plugins/examples/gRPC/area_calculator/
echo '==== RUNNING consumer-jvm'
cd consumer-jvm
./gradlew check && \
cat ~/pact-plugins/examples/gRPC/area_calculator/consumer-jvm/build/pacts/grpc-consumer-jvm-area-calculator-provider.json | jq .
```{{exec}}

### GoLang

```sh
cd ~/pact-plugins/examples/gRPC/area_calculator/
echo '==== RUNNING consumer-go'
cd consumer-go
go test -c
LOG_LEVEL=info ./consumer.test
```{{exec}}

### Rust

```sh
cd ~/pact-plugins/examples/gRPC/area_calculator/
echo '==== RUNNING consumer-rust'
cd consumer-rust
cargo test
cat /root/pact-plugins/examples/gRPC/area_calculator/consumer-rust/target/pacts/grpc-consumer-rust-area-calculator-provider.json | jq .
```{{exec}}


## Providers

### JVM


```sh
cd ~/pact-plugins/examples/gRPC/area_calculator/
echo '==== RUNNING provider-jvm'
cd provider-jvm
cp ../consumer-jvm/build/pacts/* server/src/test/resources/pacts
cp ../consumer-rust/target/pacts/* server/src/test/resources/pacts
cp ../consumer-go/pacts/* server/src/test/resources/pacts
./gradlew check
```{{exec}}


### GoLang

```sh
cd ~/pact-plugins/examples/gRPC/area_calculator/
echo '==== RUNNING consumer-go'
cd provider-go
set -x
go build provider.go
nohup ./provider > provider.go.out 2>&1 &
PID=$!
trap "kill $PID" EXIT
sleep 1
ls -la
PROVIDER_PORT=$(cat provider.go.out | cut -f4 -d:)
pact_do_not_track=true ~/bin/pact_verifier_cli -f ../consumer-jvm/build/pacts/grpc-consumer-jvm-area-calculator-provider.json\
  -f ../consumer-rust/target/pacts/grpc-consumer-rust-area-calculator-provider.json\
  -f ../consumer-go/pacts/grpc-consumer-go-area-calculator-provider.json\
  -p "$PROVIDER_PORT"
```{{exec}}