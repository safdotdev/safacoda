#!/bin/bash

[ -f ~/pact-plugins/examples/gRPC/area_calculator/consumer-jvm/build/pacts/grpc-consumer-jvm-area-calculator-provider.json  ] && echo "done"
[ -f ~/pact-plugins/pact-plugins/examples/gRPC/area_calculator/consumer-rust/target/pacts/grpc-consumer-rust-area-calculator-provider.json  ] && echo "done"