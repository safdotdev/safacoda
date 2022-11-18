## Workshop Prerequisites

You must have:

- A Pactflow account (https://pactflow.io)
  - A [read/write API Token](https://docs.pactflow.io/#configuring-your-api-token) from your Pactflow account
- A SWH account (https://swagger.io/tools/swaggerhub/)
  - A swaggerhub API key
- a basic understanding of APIs, unit testing and how to operate a linux terminal

### Goals

You will learn how:

1. Implement contract testing as part of a design first strategy
2. To use OpenAPI to document your provider API
3. To use API testing tools such as ReadyAPI, Dredd or Postman to test your providers API
4. To publish provider contract (OpenAPI document + Test Results) to Pactflow
5. To use existing mocking tools (such as Mountebank or Wiremock) to create a consumer contract
6. To publish consumer contract(s) (pact files) to Pactflow
7. To prevent the provider deploying breaking changes to an environment, such as production
8. To prevent the consumer deploying breaking changes to an environment, such as production

## Agenda

You will:

1. Create and document an API using [OpenAPI Specification](https://www.openapis.org/) and SwaggerHub Editor
2. Write tests for the API using the Dredd API testing tool
3. Publish the _provider contract_ (an OpenAPI document + Test Results) to Pactflow
4. Deploy the provider to production
5. Write the API consumer
6. Write tests for an API client using Mountebank to mock the API, and convert those mocks into a _consumer contract_
7. Publish the consumer contract to Pactflow
8. Deploy the consumer to production
9. Learn about Pactflow's breaking change detection system

### Tools used

- Node - for the applications being tested
- [Mountebank](http://www.mbtest.org/) - for API mocking
- [Dredd](https://dredd.org/en/latest/index.html) - for API Testing
