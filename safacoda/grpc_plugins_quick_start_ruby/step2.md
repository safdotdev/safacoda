## Run your first gRPC consumer and provider in Ruby, it will be a simple Area Calculator


The Killercoda session is already pre-loaded with our pre-requisites, but you can following the pre-reqs and download the example, if you are following along on your local machine.

### Prerequisites

- Ruby version 2 or higher

#### gRPC

To install gRPC, run the following command:

`gem install grpc`{{exec}}

#### gRPC tools

Ruby's gRPC tools include the protocol buffer compiler `protoc` and the special
plugin for generating server and client code from the `.proto` service
definitions. For the first part of our quick-start example, we've already
generated the server and client stubs from
[area_calculator.proto](https://github.com/pact-foundation/pact-plugins/blob/main/examples/gRPC/area_calculator/proto/area_calculator.proto),
but you'll need the tools for the rest of our quick start, as well as later
tutorials and your own projects.

To install gRPC tools, run the following command:

`gem install grpc-tools`{{exec}}

### Download the example

You'll need a local copy of the example code to work through this quick start, on your local machine
Download the example code from our GitHub repository (the following command
clones the entire repository, but you just need the examples for this quick start
and other tutorials):

You can copy this snippet by clicking on it on your local machine

```sh
git clone -b test --depth 1 --shallow-submodules https://github.com/you54f/pact-ruby-ffi
cd examples/area_calculator
```{{copy}}

### Install our dependencies

We need to run this locally or in the Killercoda environment

`make install_demo_grpc`{{exec}}

It will change directory into our sample project and run `bundle install` to install our project dependencies

### Run a gRPC application

Run the server as a background process with the `&` symbol - note the process identifier stored as `&_pid` , we will use this later to close down the server:

- `ruby examples/area_calculator/area_calculator_provider.rb &_pid=$!`{{exec}}

_note:_ If you don't want to run as a background process, you will need to open a new tab, to run the client.

You can now run the client:

- `ruby examples/area_calculator/area_calculator_consumer_run.rb`{{exec}}

You should see the area result, and you will see a log message from the provider stating it received the request, and calculated a result.

Congratulations! You've just run a client-server application with gRPC.

1. Lets close down our running provider, we use our process identifier, and tell our system to kill that process

`kill $_pid`{{exec}}


### Take a look at the files used in this step

- `examples/area_calculator/area_calculator_consumer_run.rb`
- `examples/area_calculator/area_calculator_consumer.rb`
- `examples/area_calculator/area_calculator_provider.rb`
- `examples/area_calculator/proto/area_calculator.proto`
- `examples/area_calculator/lib/area_calculator_pb.rb`
- `examples/area_calculator/lib/area_calculator_services_pb.rb`

1. Click the filename above to copy it.
1. Click somewhere in the `editor` tab
1. press `ctrl+p` or `command+p` to search for a file
1. Press `ctrl+v` or `command+v` to paste the filename and press enter
