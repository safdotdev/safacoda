<img align="right" src="./assets/pact-foundation.png" width="300">

Consumer-drive contracts (CDC) was first promoted as a testing technique in 2006 by [Ian Robinson](https://martinfowler.com/articles/consumerDrivenContracts.html). CDC has been slow to adapt over the years, but remains a vital testing technique. Recently our community has [adopted](https://www.thoughtworks.com/radar/techniques/consumer-driven-contract-testing) a keener interest in CDC as it's a helpful method for testing microservices.

CDC is a concept and testing approach that embraces the perspective of multiple _consumers_ that communicate with providers. Typically, testing tends to define API contracts from the _providers_ perspective. Through a registry of contracts, multiple consumers now have a voice to provide producers their expectations on how data should be exchanged between the consumers and producers.

Over the years the [Pact Foundation](https://pact.io/) has established itself as the primary framework that implements this testing approach.

This scenario leverages on Kubernetes as it's ideal for running microservices and containers.

You will explore a sample application composed of several microservices. The application aggregates population and COVID-19 datasources and presents data at an API gateway. We will use Pact to verify the API.

You will learn how to:

1. set up a Pact Broker on Kubernetes
2. write a consumer that defines and publishes Pact contracts
3. deploy and run a few Spring Boot microservices on Kubernetes
4. connect microservices to a database and public data source
5. verify the consumer pacts against a producer
6. find API defects and fix them
