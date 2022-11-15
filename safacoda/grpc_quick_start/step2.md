## gRPC Area Calculator Quick Start - Ruby 


The Killercoda session is already pre-loaded with our pre-requisites, but you can following the pre-reqs and download the example, if you are following along on your local machine.

### Prerequisites

- Ruby version 2 or higher

#### gRPC

To install gRPC, run the following command:

```sh
$ gem install grpc
```

#### gRPC tools

Ruby's gRPC tools include the protocol buffer compiler `protoc` and the special
plugin for generating server and client code from the `.proto` service
definitions. For the first part of our quick-start example, we've already
generated the server and client stubs from
[helloworld.proto](https://github.com/grpc/grpc/tree/{{< param grpc_vers.core >}}/examples/protos/helloworld.proto),
but you'll need the tools for the rest of our quick start, as well as later
tutorials and your own projects.

To install gRPC tools, run the following command:

```sh
$ gem install grpc-tools
```

### Download the example

You'll need a local copy of the example code to work through this quick start, on your local machine
Download the example code from our GitHub repository (the following command
clones the entire repository, but you just need the examples for this quick start
and other tutorials):

```sh
# Clone the repository to get the example code:
$ git clone -b test --depth 1 --shallow-submodules https://github.com/you54f/pact-ruby-ffi
# Navigate to the "Area Calculator" Ruby example:
$ cd examples/area_calculator
```

### Install our dependencies

`make install_demo_grpc`{{exec}}

### Run a gRPC application

From the `examples/area_calculator` directory:

 1. Run the server as a background process with the `&` symbol - note the process identifier, we will use this later to close down the server:

`ruby examples/area_calculator/area_calculator_provider.rb &`{{exec}}

_note:_ If you don't want to run as a background process, you will need to open a new tab, to run the client.

 1. You can now run the client:

`ruby examples/area_calculator/area_calculator_consumer_run.rb`

You should see the area result, and you will see a log message from the provider stating it received the request, and calculated a result.

Congratulations! You've just run a client-server application with gRPC.

1. Lets close down our running provider, we use our process identifier, and tell our system to kill that process

`ps -a`{{exec}}
`kill <pid>`{{exec}}

We can do it all in one, but this will kill any other processes called `ruby` too, you have been warned :) It is safe in the Killercoda, but be careful if running locally!

`ps -a | grep -e 'ruby' | awk '{print $1}' | xargs kill`{{exec}}