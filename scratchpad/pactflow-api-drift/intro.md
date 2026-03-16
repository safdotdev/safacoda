In the scenario, you will learn the basics of Drift, the new API testing tool from PactFlow, and how to use it to manage API documentation and implementation drift.

The course is written in NodeJS, however, extensive experience with the language will not be required for the workshop.

## Workshop Prerequisites

You must have:

- a PactFlow account (https://pactflow.io)
- obtained a [read/write API Token](https://docs.pactflow.io/#configuring-your-api-token) from your PactFlow account
- a basic understanding of APIs, unit testing and how to operate a linux terminal

### Goals

You will learn how:

1. API Drift affects providers from delivering change, impacts consumer confidence, causing friction between teams.
2. To use PactFlow Drift to prevent API drift and ensure that your API documentation and implementation are in sync
3. Where Drift fits into your API Testing Strategy
4. To install Drift, and get started with writing your first Drift tests
5. Manage state with Drift, and use it to test your API's behavior in different scenarios
6. Embedding Drift into your Test Framework
7. Embedding Drift into your CI/CD pipeline, and using it to prevent API drift from reaching production
8. To introduce advanced Drift features such as
   1.  Dealing with Authenticated APIs
   2.  Test Lifecycle Hooks and Lua Scripting
       1.  Data Cleanup
       2.  Dynamic Request/Response Manipulation
   3.  Test Data Management with Lua Scripting
   4.  Advanced Debugging and Troubleshooting Techniques
       1.  Analyzing Test Failures
       2.  Script Debugging
   5.  Test parallelization

## Agenda

You will:

1. Create and document an API using [OpenAPI Specification](https://www.openapis.org/)
1. Write tests for the API using the Drift spec-first testing tool
1. Publish the _provider contract_ (an OpenAPI document + testing evidence) to PactFlow
1. Deploy the provider to production
1. Write the API consumer
1. Write tests for an API client using Mountebank to mock the API, and convert those mocks into a _consumer contract_
1. Publish the consumer contract to PactFlow
1. Deploy the consumer to production
1. Learn about PactFlow's breaking change detection system

### Tools used

- Node - for the applications being tested
- [Mountebank](http://www.mbtest.org/) - for API mocking
- [Drift](https://pactflow.github.io/drift-docs) - for Spec-First API Testing
- [PactFlow](https://pactflow.io) - for contract sharing and compatibility checks