## Workshop Prerequisites

- Nothing! Just you and a bit of time

## Goals

Create a simple gRPC application, in various languages, and test with Pact using the [pact-protobuf-plugin](https://github.com/pactflow/pact-protobuf-plugin) to showcase Pact's multi-protocol approach with the [pact-plugin](https://github.com/pact-foundation/pact-plugins) eco-system

You will:

1. Learn about the basics of gRPC
1. Run your first gRPC consumer and provider in one of several languages, it will be a simple Area Calculator
1. Write your first gRPC consumer test with Pact using the [pact-protobuf-plugin](https://github.com/pactflow/pact-protobuf-plugin) which will generate a pact file.
1. Verify your gRPC provider application with Pact, locally
1. Setup a locally running Pact Broker
1. Publish your consumer gRPC test to the Pact broker
1. Verify your gRPC provider application with Pact, using the local pact file, publishing results to the broker
1. Verify your gRPC provider application with Pact, using the published pact file, publishing results to the broker

## Setting Up

### Download the example

You'll need a local copy of the example code to work through this quick start, on your local machine, but you wont need it for the Killercoda, as its already downloaded.

Download the example code from our GitHub repository (the following command
clones the entire repository, but you just need the examples for this quick start
and other tutorials):

You can copy this snippet by clicking on it on your local machine

```sh
git clone -b test --depth 1 --shallow-submodules https://github.com/pact-plugins
```{{copy}}


### Install our Protobuf Plugin

- `~/pact-plugins/scripts/install-plugin-cli.sh`{{exec}}
- `~/bin/pact-plugin-cli -y install https://github.com/pactflow/pact-protobuf-plugin/releases/latest`{{exec}}

### Install the Pact Verifier

- `~/pact-plugins/scripts/install-verifier-cli.sh `{{exec}}


### Install the FFI libraries

We will use the Pact-Go's helper function, to install the right version for our platform, you can download them directly from the [pact-reference release page](https://github.com/pact-foundation/pact-reference/releases/tag/libpact_ffi-v0.3.14)

- `go install github.com/pact-foundation/pact-go/v2@2.x.x`{{exec}}
- `$HOME/go/bin/pact-go -l DEBUG install`{{exec}}
- `sudo chmod 644 /usr/local/lib/libpact_ffi.so`{{exec}}
- `ls -la /usr/local/lib/`{{exec}}


### Start your tests from here!
  
- `cd ~/pact-plugins/examples/gRPC/area_calculator/`{{exec}}

## Consumers

### JVM

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
cat ~/pact-plugins/examples/gRPC/area_calculator/consumer-rust/target/pacts/grpc-consumer-rust-area-calculator-provider.json | jq .
```{{exec}}


## Providers

### JVM


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
go build provider.go
./provider > provider.go.out 2>&1 &
PID=$!
sleep 1
ls -la
PROVIDER_PORT=$(cat provider.go.out | cut -f4 -d:)
pact_do_not_track=true ~/bin/pact_verifier_cli -f ../consumer-jvm/build/pacts/grpc-consumer-jvm-area-calculator-provider.json\
  -f ../consumer-rust/target/pacts/grpc-consumer-rust-area-calculator-provider.json\
  -f ../consumer-go/pacts/grpc-consumer-go-area-calculator-provider.json\
  -p "$PROVIDER_PORT"
kill $PID
```{{exec}}

# CSV

## Setting Up

### Install the CSV Plugin

- `~/bin/pact-plugin-cli -y install https://github.com/pact-foundation/pact-plugins/releases/tag/csv-plugin-0.0.3`{{exec}}

### Start our tests from here

- cd ~/pact-plugins/examples/csv

## Consumers

### JVM

```sh
cd ~/pact-plugins/examples/csv/
echo '==== RUNNING consumer-jvm'
cd csv-consumer-jvm
./gradlew check
cat ~/pact-plugins/examples/csv/csv-consumer-jvm/build/pacts/CsvClient-CsvServer.json | jq .
```{{exec}}

### Rust

```sh
cd ~/pact-plugins/examples/csv
echo '==== RUNNING consumer-rust'
cd csv-consumer-rust
cargo test -- --test-threads 1
cat ~/pact-plugins/examples/csv/csv-consumer-rust/target/pacts/CsvClient-CsvServer.json | jq .
```{{exec}}

## Providers

### Rust

```sh
cd ~/pact-plugins/examples/csv
echo '==== RUNNING provider-rust'
cd csv-provider
cargo build
./target/debug/csv-provider & PID=$!
~/bin/pact_verifier_cli -f ../csv-consumer-jvm/build/pacts/CsvClient-CsvServer.json -p 8080
~/bin/pact_verifier_cli -f ../csv-consumer-rust/target/pacts/CsvClient-CsvServer.json -p 8080
kill $PID
```{{exec}}

# Protobufs