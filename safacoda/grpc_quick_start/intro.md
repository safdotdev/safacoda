## Workshop Prerequisites

- Nothing! Just you and a bit of time

## Goals

See how a language implementation can interact with the [Pact FFI](https://github.com/pact-foundation/pact-reference/tree/master/rust/pact_ffi#pact-ffi), and create up to V4 specification pact files, and interact with the [pact-plugin](https://github.com/pact-foundation/pact-plugins/) ecosystem

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
