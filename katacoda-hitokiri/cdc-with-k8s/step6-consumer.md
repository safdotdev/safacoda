With the Pact framework, it's the consumers that create the Pacts. Independent of the producers or any service, the consumers write testing code that creates conversations with local mocked services. The Mocks are the consumer's perspectives of how the producers should react to the consumer's requests.

<img align="right" src="./assets/nodejs.png" width="150">
This particular consumer is written in Node.js. It also uses Jest - a delightful JavaScript Testing Framework with a focus on simplicity. The Pact framework works with many languages and testing fromworks including Node.js and Java used in this scenario. The current list of [supported languages](https://docs.pact.io/implementation_guides/other_languages) makes it attractive for use with Kubernetes where we often mix languages in different containers.

<img align="right" src="./assets/jest.png" width="150">
This example is directly based on the work from [Marie Drake](https://www.mariedrake.com/). Marie has a helpful post [Contract Testing with Pact.js and Jest](https://www.mariedrake.com/post/contract-testing-with-pact-js-and-jest) that describes in more detail how this works. This scenario only scratches the surface and Marie Drake describes many more of its capabilities.

Move to the _pact_ directory.

`cd ~/cdc-with-k8s/pact`{{execute}}

## Generate Pact Contracts

Update npm for this environment. This may take a moment as it sorts out the [un-un-publishing of left-pad](https://www.theregister.com/2016/03/23/npm_left_pad_chaos/). `¯\_(ツ)_/¯`

`npm install`{{execute}}

Produce the two Pact files.

`npm run test:consumer-a`{{execute}}

`npm run test:consumer-b`{{execute}}

Once complete, new Pact JSON files are in the pacts directory. Inspect one of the contract files.

`ccat pacts/consumer_a-aggregator.json | jq -C .`{{execute}}

## Publish Pacts to Pact Broker

Define access to the Pact Broker.

`export PACT_BROKER_URL=https://[[HOST_SUBDOMAIN]]-30111-[[KATACODA_HOST]].environments.katacoda.com/`{{execute}}

`export BROKER_USERNAME=pactbroker`{{execute}}

`export BROKER_PASSWORD=pactbroker`{{execute}}

Publish the pact to the broker.

`npm run publish:pact`{{execute}}

Verify the pact has been published to the [Pact Broker](https://[[HOST_SUBDOMAIN]]-30111-[[KATACODA_HOST]].environments.katacoda.com/).
