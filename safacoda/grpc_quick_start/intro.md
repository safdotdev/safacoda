## Workshop Prerequisites

- Nothing! Just you and a bit of time

## Goals

Create a simple gRPC application, in Ruby, and test with Pact using the [pact-protobuf-plugin](https://github.com/pactflow/pact-protobuf-plugin) to showcase Pact's multi-protocol approach with the [pact-plugin](https://github.com/pact-foundation/pact-plugins) eco-system

You will:

1. Learn about the basics of gRPC
2. Run your first gRPC consumer and provider in Ruby, it will be a simple Area Calculator
3. Write your first gRPC consumer test with Pact using the [pact-protobuf-plugin](https://github.com/pactflow/pact-protobuf-plugin)
4. Test your gRPC consumer application with Pact, locally, which will generate a pact file.
5. Verify your gRPC provider application with Pact, locally
6. Setup a locally running Pact Broker
7. Publish your consumer gRPC test to the Pact broker
8. Verify your gRPC provider application with Pact, using the local pact file, publishing results to the broker
9. Verify your gRPC provider application with Pact, using the published pact file, publishing results to the broker
