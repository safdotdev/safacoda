## An example scenario: Product API

To learn the basic concepts of Bi-Directional-Contract-testing, we will work through an example scenario authoring a consumer test between a consumer (Product Web) and its provider (the Product API).

![Scenario](./assets/scenario.png)

We will implement this system using an approach referred to as _specification first design_, where we will first design the API by hand and then write the actual implementation of the provider.

This is in contrast to _consumer driven contracts_ where the API consumers can drive the design of the API (read more about [consumer driven contracts](https://docs.pact.io)).

One challenge with this approach, is we need to ensure that our provider's implementation doesn't drift from the document. There are several ways to achieve this, which we will discuss in step 3.

We also need to ensure that the provider doesn't introduce a change that will break its service consumers - for this, we will use a Pactflow feature called [Bi-Directional Contract Testing](https://pactflow.io/bi-directional-contract-testing/) to ensure neither the the API Consumer or Provider can accidentally break the integration.

### Definitions

Let's get some terminology out of the way so we have a shared vocabulary:

- **Consumer**: An application that makes use of the functionality or data from another application to do its job. For applications that use HTTP, the consumer is always the application that initiates the HTTP request (eg. the web front end), regardless of the direction of data flow. For applications that use queues, the consumer is the application that reads the message from the queue.

- **Provider**: An application (often called a service) that provides functionality or data for other applications to use, often via an API. For applications that use HTTP, the provider is the application that returns the response. For applications that use queues, the provider (also called producer) is the application that writes the messages to the queue.

- A **consumer contract** is a collection of interactions which describe how the Consumer expects the Provider to behave. Each Consumer will have its own unique consumer contract for each of its Providers.

- A **provider contract** specifies the capability of the Provider. In this workshop, it will take the form of an OpenAPI document, but may be other formats such as a GraphQL schema, a SOAP XSD, a protobuf definition and so on.

### Further Reading

You can read more about this feature: https://pactflow.io/bi-directional-contract-testing/

## Agree API on paper

We have 3 main endpoints:

1. `POST /products` - create a new product
1. `GET /products` - gets all products
1. `GET /products/:id` - gets a single product

### Endpoints / Example Response

| Endpoint         | Example Response                                                                                                                                                                                                |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `GET /products`  | `[{"id":"09","type":"CREDIT_CARD","name":"Gem Visa","version":"v1"},{"id":"10","type":"CREDIT_CARD","name":"28 Degrees","version":"v1"},{"id":"11","type":"PERSONAL_LOAN","name":"MyFlexiPay","version":"v2"}]` |
| `GET /product/1` | `{"id":"09","type":"CREDIT_CARD","name":"Gem Visa","version":"v1"}`                                                                                                                                             |
| `POST /products` | `{"id":"09","type":"CREDIT_CARD","name":"Gem Visa","version":"v1"}`                                                                                                                                             |

## Create OAS in SWH

1. [Login](https://app.swaggerhub.com/login) into Swaggerhub, either SSO, GitHub, or Email.
2. Get your [API Key](https://app.swaggerhub.com/settings/apiKey) and select `Copy API Key`
3. Type `npx swaggerhub-cli configure`{{execute}}
   1. If you have a custom SwaggerHub URL, enter it when asked, otherwise press enter, to select the default `https://api.swaggerhub.com`
   2. When asked for your `API Key`, paste the token from step 2 in.
4. Set an environment variable with your SwaggerHub Org name. Note this is case sensitive (or needs to be uppercased)
   1. Click to copy this command -> `export SWAGGERHUB_ORG=` and paste in Tab 1 followed by your SwaggerHub Org name.
5. `npx swaggerhub-cli api:create $SWAGGERHUB_ORG/pactflow-demo/v1.0.0 --visibility=public -f oas/products_v1.0.0.yml`{{execute}}

```yml
openapi: 3.0.1
info:
  title: Product API
  description: Pactflow Product API demo
  version: 1.0.0
paths:
  /products:
    post:
      summary: Create a product
      description: Creates a new product
      operationId: createProduct
      requestBody:
        description: Create a new Product
        required: true
        content:
          application/json:
            schema:
              $ref: "#/components/schemas/Product"
            examples:
              application/json:
                value:
                  id: "1234"
                  type: "food"
                  price: 42
      responses:
        "200":
          description: successful operation
          content:
            "application/json;charset=utf-8":
              schema:
                oneOf:
                  - $ref: "#/components/schemas/Product"
              examples:
                application/json:
                  value:
                    id: "1234"
                    type: "food"
                    price: 42
    get:
      summary: List all products
      description: Returns all products
      operationId: getAllProducts
      responses:
        "200":
          description: successful operation
          content:
            "application/json;charset=utf-8":
              schema:
                type: "array"
                items:
                  $ref: "#/components/schemas/Product"
              examples:
                application/json:
                  value:
                    - id: "1234"
                      type: "food"
                      price: 42
                      name: "pizza"
                      version: "1.0.0"
        "400":
          description: Invalid ID supplied
          content: {}
  /product/{id}:
    get:
      summary: Find product by ID
      description: Returns a single product
      operationId: getProductByID
      parameters:
        - name: id
          in: path
          description: ID of product to get
          schema:
            type: string
          required: true
          example: 10
      responses:
        "200":
          description: successful operation
          content:
            "application/json;charset=utf-8":
              schema:
                $ref: "#/components/schemas/Product"
              examples:
                application/json:
                  value:
                    id: "1234"
                    type: "food"
                    price: 42
                    name: "pizza"
                    version: "1.0.0"
        "400":
          description: Invalid ID supplied
          content: {}
        "404":
          description: Product not found
          content: {}
components:
  schemas:
    Product:
      type: object
      required:
        - id
        - name
        - price

      properties:
        id:
          type: string
        type:
          type: string
        name:
          type: string
        version:
          type: string
        price:
          type: number
```

## Create Provider Mock from OAS (AutoMock)

Create AutoMock Integration of OAS

1. `npx swaggerhub-cli integration:create $SWAGGERHUB_ORG/pactflow-demo/v1.0.0 -f integrations/api_auto_mocking.json`{{execute}}
2. `npx swaggerhub-cli integration:list $SWAGGERHUB_ORG/pactflow-demo/v1.0.0 | tail -n 1 | cut -f1,2 -d' ' | xargs echo $SWAGGERHUB_ORG/pactflow-demo/v1.0.0 | sed -e "s/ /\//g" | xargs npx swaggerhub-cli integration:execute`{{execute}}
3. `mocked_endpoint=$(npx swaggerhub-cli api:get $SWAGGERHUB_ORG/pactflow-demo/v1.0.0 --json | jq -r '.servers[0].url')`{{execute}}
   1. `curl -s $mocked_endpoint/products | jq .`{{execute}}
   2. `curl -s $mocked_endpoint/product/42 | jq .`{{execute}}

## Create tests for AutoMock

Create test for auto mock with any API testing tool

1.  `mocked_endpoint=$(npx swaggerhub-cli api:get $SWAGGERHUB_ORG/pactflow-demo/v1.0.0 --json | jq -r '.servers[0].url')`{{execute}}
    1.  `curl -s $mocked_endpoint/products | jq .`{{execute}}
    2.  `curl -s $mocked_endpoint/product/42 | jq .`{{execute}}
2.  `endpoint=$mocked_endpoint yq -i '.endpoint = strenv(endpoint)' dredd.yml`{{execute}}
3.  `spec=oas/products_v1.0.0.yml yq -i '.blueprint = strenv(spec)' dredd.yml`{{execute}}
4.  `npx -y dredd $mocked_endpoint`{{execute}}

## Upload results to Pactflow

8. Sign up to Pactflow
9. Create a devmock environment
10. Go to the API tokens page
11. Click to copy `PACT_BROKER_BASE_URL=` and paste into tab 1, followed by `COPY PACTFLOW BASE URL` button, then paste that into tab 1 and press enter
12. Click to copy `PACT_BROKER_TOKEN=` and paste into tab 1, followed by the read/write `COPY` button, then paste that into tab 1 and press enter
13. publish results to pactflow (devmock) env
14. `npx -y dredd $mocked_endpoint| pactflow publish-provider-contract oas/products_v1.0.0.yml --provider swh-pf-demo-provider --provider-app-version 1.0.0 --branch testbranch --content-type 'application/yaml' --verification-exit-code=$? --verification-results output/report.md --verification-results-content-type 'plain/text' --verifier 'dredd';`{{execute}}
15. Check if you can deploy the mock provider
16. `pact-broker can-i-deploy --pacticipant swh-pf-demo-provider --version 1.0.0 --to-environment devmock`{{execute}}
17. Deploy the mock provider and record it as deployed to the devmock environment
    1. `pact-broker record-deployment --pacticipant swh-pf-demo-provider --version 1.0.0 --environment devmock`{{execute}}

## Store OAS in SCM (Git)

5. Sign up to GitHub
6. Create Repository
7. Connect GitHub/SCM integration of OAS

https://support.smartbear.com/swaggerhub/docs/integrations/github-sync.html

## Make changes to OAS in SWH

10. Make changes to OAS in SWH
11. New changes published to Pactflow

## Create Provider Stub from SWH/Pactflow

12. Create provider stub from SWH

servers:

- url: http://localhost:8080
  description: localhost

13. Test provider implementation and upload to Pactflow
    1. Test with any api tool
    2. Test with ReadyAPI

## Create Consumer Stub from SWH/Pactflow

Create consumer stub and Test consumer implementation with Pact and upload to Pactflow

- Test with Pact
- Test with Adapter

1.  Publish consumer pacts
    1. `pact-broker publish pacts/pact_bdc_v1.0.0.json --consumer-app-version 1.0.0 --branch testbranch0`{{execute}}
2.  Check if consumer if safe to deploy
    1. `pact-broker can-i-deploy --pacticipant pactflow-example-consumer --version 1.0.0 --to-environment devmock`{{execute}}
3.  Deploy consumer and record consumer existence in devmock environment
    1. `pact-broker record-deployment --pacticipant pactflow-example-consumer --version 1.0.0 --environment devmock`{{execute}}

## Making a consumer change 1

Consumer requires additional field from provider which provider already provides

Safe

18. `pact-broker publish pacts/pact_bdc_v1.0.1.json --consumer-app-version 1.0.1 --branch testbranch1`{{execute}}
19. `pact-broker can-i-deploy --pacticipant pactflow-example-consumer --version 1.0.1 --to-environment production`{{execute}}

## Making a consumer change 2

Consumer requires additional field from provider which provider does provide

Unsafe

20. `pact-broker publish pacts/pact_bdc_v1.0.2.json --consumer-app-version 1.0.2 --branch testbranch2`{{execute}}
21. `pact-broker can-i-deploy --pacticipant pactflow-example-consumer --version 1.0.2 --to-environment production`{{execute}}

## Making a consumer change 3

Consumer changes to expect via a new endpoint

Unsafe

1.  `pact-broker publish pacts/pact_bdc_v1.0.3.json --consumer-app-version 1.0.3 --branch testbranch3`{{execute}}
2.  `pact-broker can-i-deploy --pacticipant pactflow-example-consumer --version 1.0.3 --to-environment production`{{execute}}
