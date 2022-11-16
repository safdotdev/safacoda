## Workshop Prerequisites

- Nothing! Just you and a bit of time

## Goals

Test with Pact using the [pact-plugin](https://github.com/pact-foundation/pact-plugins) eco-system

1. Test a gRPC Protobuf Area Calculator Example, to show the pact-plugin frameworks custom transport capabilities
2. Test a CSV Example, to show the pact-plugin frameworks custom content matching ability
3. Test a Protobuf example, which tests the pact-plugin protobuf file directly, to show the basics of how you could configure your own plugin in the future.

# gRPC Area Calculator Example

This is a simple gRPC example that can receive a shape via gRPC, and return the area for the shape. See the [proto file](proto/area_calculator.proto)
for more details.

The proto file has a single service method which these examples will be testing:

```protobuf
  rpc calculate (ShapeMessage) returns (AreaResponse) {}
```

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


The example [JVM consumer project](https://github.com/pact-foundation/pact-plugins/tree/main/examples/gRPC/area_calculator/consumer-jvm) contains a simple consumer in Java generated from Gradle and a JUnit 5 consumer test.

```sh
cd ~/pact-plugins/examples/gRPC/area_calculator/
echo '==== RUNNING consumer-jvm'
cd consumer-jvm
./gradlew check && \
cat ~/pact-plugins/examples/gRPC/area_calculator/consumer-jvm/build/pacts/grpc-consumer-jvm-area-calculator-provider.json | jq .
```{{exec}}

### GoLang

The example [Go consumer project](https://github.com/pact-foundation/pact-plugins/tree/main/examples/gRPC/area_calculator/consumer-go) contains a simple consumer and a Go consumer test.


```sh
cd ~/pact-plugins/examples/gRPC/area_calculator/
echo '==== RUNNING consumer-go'
cd consumer-go
go test -c
LOG_LEVEL=info ./consumer.test
```{{exec}}

### Rust

The example [Rust consumer project](https://github.com/pact-foundation/pact-plugins/tree/main/examples/gRPC/area_calculator/consumer-rust) contains a simple consumer generated with Prost and a Rust consumer test.


```sh
cd ~/pact-plugins/examples/gRPC/area_calculator/
echo '==== RUNNING consumer-rust'
cd consumer-rust
cargo test
cat ~/pact-plugins/examples/gRPC/area_calculator/consumer-rust/target/pacts/grpc-consumer-rust-area-calculator-provider.json | jq .
```{{exec}}


## Providers

### JVM

The [provider project](https://github.com/pact-foundation/pact-plugins/tree/main/examples/gRPC/area_calculator/provider-jvm) contains a Kotlin server and a Java/JUnit 5 test to verify the Pact file from the consumer projects.

It can also be verified using the Rust verifier CLI.

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

# CSV Examples

These examples demonstrate using the prototype CSV plugin to support using matching requests and responses
with CSV content. There are two consumer projects, one written in Java and the other in Rust.

The CSV provider supports the following endpoint:
* `/reports/{report}.csv`

A `GET` request will return the CSV data for the report, and a `POST` will update it.

Each consumer has two tests, one for each of the types of request to the provider.

## Setting Up

### Install the CSV Plugin

- `~/bin/pact-plugin-cli -y install https://github.com/pact-foundation/pact-plugins/releases/tag/csv-plugin-0.0.3`{{exec}}

### Install the Pact Verifier

- `~/pact-plugins/scripts/install-verifier-cli.sh `{{exec}}

### Start our tests from here

- `cd ~/pact-plugins/examples/csv`{{exec}}

## Consumers

### JVM

The Java consumer is run using Gradle, so just run `./gradlew check` in the `csv-consumer-jvm` directory and 
if the tests pass, a pact file will be created in the `build/pacts` directory.

```sh
cd ~/pact-plugins/examples/csv/
echo '==== RUNNING consumer-jvm'
cd csv-consumer-jvm
./gradlew check && \
cat ~/pact-plugins/examples/csv/csv-consumer-jvm/build/pacts/CsvClient-CsvServer.json | jq .
```{{exec}}

### Rust

The Rust consumer is run using Cargo, so just run `cargo test` in the `csv-consumer-rust` directory, and 
if the tests pass, a pact file will be created in the `target/pacts` directory.

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

# Protobuf Examples

These examples demonstrate using the prototype Protobuf plugin to support matching Protobuf messages. 
There are two consumer projects, one written in Java and the other in Rust.

The [proto file](https://github.com/pact-foundation/pact-plugins/blob/main/proto/plugin.proto) for the plugin interface is used for these tests.  

Each consumer has two tests, one for the simple InitPluginResponse message and one for the more complex
InteractionResponse message.

## Setting Up

### Install our Protobuf Plugin

- `~/pact-plugins/scripts/install-plugin-cli.sh`{{exec}}
- `~/bin/pact-plugin-cli -y install https://github.com/pactflow/pact-protobuf-plugin/releases/latest`{{exec}}

### Install the Pact Verifier

- `~/pact-plugins/scripts/install-verifier-cli.sh `{{exec}}

### Start our tests from here

- cd ~/pact-plugins/examples/protobuf

## Consumers

### JVM

The Java consumer is run using Gradle, so just run `./gradlew check` in the `protobuf-consumer` directory and 
if the tests pass, a pact file will be created in the `build/pacts` directory.

```sh
cd ~/pact-plugins/examples/protobuf/
echo '==== RUNNING consumer-jvm'
cd protobuf-consumer-jvm
./gradlew check && \
cat ~/pact-plugins/examples/protobuf/protobuf-consumer-jvm/build/pacts/protobuf-consumer-protobuf-provider.json | jq .
```{{exec}}

### Rust

The Rust consumer is run using Cargo, so just run `cargo test` in the `protobuf-consumer-rust` directory, and 
if the tests pass, a pact file will be created in the `target/pacts` directory.

```sh
cd ~/pact-plugins/examples/protobuf
echo '==== RUNNING consumer-rust'
cd protobuf-consumer-rust
cargo test
cat ~/pact-plugins/examples/protobuf/protobuf-consumer-rust/target/pacts/protobuf-consumer-rust-protobuf-provider.json | jq .
```{{exec}}

## Providers

### GoLang

```sh
cd ~/pact-plugins/examples/protobuf
echo '==== RUNNING provider-go'
cd protobuf-provider
go build main.go
./main & PID=$!
timeout --foreground -s TERM 30s bash -c 'while [[ "$(curl -s -o /dev/null -m 3 -L -w ''%{http_code}'' -XPOST -d'{}' http://127.0.0.1:8111)" != "200" ]]; do echo "Waiting for http://127.0.0.1:8111" && sleep 2; done'
~/bin/pact_verifier_cli -f ../protobuf-consumer-rust/target/pacts/protobuf-consumer-rust-protobuf-provider.json -p 8111
~/bin/pact_verifier_cli -f ../protobuf-consumer-jvm/build/pacts/protobuf-consumer-protobuf-provider.json -p 8111
kill $PID
```{{exec}}