## Download Pact CLI tools

1. Try `pactflow`{{exec}}

- `./pact_helper.sh doctor`{{execute}}
- `./pact_helper.sh install-pact-cli docker`{{execute}}
- `./pact_helper.sh uninstall-pact-cli docker`{{execute}}
- `./pact_helper.sh install-pact-cli ruby`{{execute}}
- `./pact_helper.sh uninstall-pact-cli ruby`{{execute}}
- `./pact_helper.sh install-pact-cli standalone`{{execute}}
- `./pact_helper.sh uninstall-pact-cli standalone`{{execute}}
- `./pact_helper.sh pactflow-login`{{execute}}
- `./pact_helper.sh pactflow-generate-project`{{execute}}
- `./pact_helper.sh pactflow-generate-project javascript-node-provider-mocha`{{execute}}
- `./pact_helper.sh pactflow-download-demo cdct`{{execute}}
- `./pact_helper.sh pactflow-download-demo bdct`{{execute}}
- `./pact_helper.sh pactflow-download-demo workshops`{{execute}}
- `./pact_helper.sh pactflow-download-demo bdct example-bi-directional-consumer-msw`{{execute}}
- `./pact_helper.sh pactflow-download-demo bdct all`{{execute}}
- `./pact_helper.sh pactflow-download-demo workshops all`{{execute}}
- `./pact_helper.sh pactflow-download-demo cdct all`{{execute}}
- `./pact_helper.sh publish-pact ./consumer_contracts/pact_bdc_v1.0.3.json v1.0.3`{{execute}}
- `./pact_helper.sh publish-provider-contract ./provider_contracts/products_v1.0.yml v1.0.5`{{execute}}
- `./pact_helper.sh publish-provider-contract ./provider_contracts/products_v1.0.yml v1.0.5`{{execute}}
- `./pact_helper.sh can-i-deploy v1.0.5`{{execute}}
- `./pact_helper.sh can-i-deploy v1.0.3 pactflow-example-consumer`{{execute}}
- `./pact_helper.sh record_deployment v1.0.3 pactflow-example-consumer`{{execute}}
- `./pact_helper.sh record_deployment v1.0.5`{{execute}}

<!-- ## Overview of OAS Files included

1. `products_v1.0.0.yml` - ok
2. `products_v1.0.1.yml` - remove price
3. `products_v1.0.2.yml` - remove name
4. `products_v1.0.3.yml` - rename path /product to /products
5. `products_v1.0.4.yml` - support /product and /products
6. `products_v1.0.5.yml` - remove /product

## Overview of Pact Files included

1. `pact_bdc_v1.0.0.json` - ok
2. `pact_bdc_v1.0.1.json` - adds price expectation in response payloads
3. `pact_bdc_v1.0.2.json` - add new field expectation visibility
4. `pact_bdc_v1.0.3.json` - updates to call new endpoint `/products`

## Overview of Steps

1. Scenario 1 - init - consumer/provider compatible
   1. `provider_contracts/products_v1.0.0.yml`
   2. `./consumer_contracts/pact_bdc_v1.0.0.json`
   3. `npx @pactflow/swagger-mock-validator provider_contracts/products_v1.0.0.yml ./consumer_contracts/pact_bdc_v1.0.0.json`
2. Scenario 2 - provider removes price - consumer/provider compatible
   1. `provider_contracts/products_v1.0.1.yml` - remove price
   2. `./consumer_contracts/pact_bdc_v1.0.0.json` - compatible (doesnt expect price)
      1. `npx @pactflow/swagger-mock-validator provider_contracts/products_v1.0.1.yml ./consumer_contracts/pact_bdc_v1.0.0.json`
   3. `./consumer_contracts/pact_bdc_v1.0.1.json` - not compatible (expects price)
      1. `npx @pactflow/swagger-mock-validator provider_contracts/products_v1.0.1.yml ./consumer_contracts/pact_bdc_v1.0.1.json`
3. Scenario 3 - provider removes name - consumer/provider incompatible
   1. `products_v1.0.2.yml` - remove name
   2. `./consumer_contracts/pact_bdc_v1.0.0.json` - compatible (expects name)
   3. `./consumer_contracts/pact_bdc_v1.0.1.json` - not compatible (expects name)
4. Scenario 4 - consumer adds new field visibility - consumer/provider incompatible
   1. `./consumer_contracts/pact_bdc_v1.0.2.json` - adds new field visibility
   2. incompatible with all provider contracts
5. Scenario 5 - provider renames endpoint - consumer/provider incompatible
   1. `products_v1.0.3.yml` - remove path /product to /products
   2. Incompatible with all consumers
      1. `npx @pactflow/swagger-mock-validator provider_contracts/products_v1.0.3.yml ./consumer_contracts/pact_bdc_v1.0.0.json`
      2. `npx @pactflow/swagger-mock-validator provider_contracts/products_v1.0.3.yml ./consumer_contracts/pact_bdc_v1.0.1.json`
6. Scenario 6 - provider supports both endpoints - consumer/provider compatible
   1. `products_v1.0.4.yml` - support /product and /products
   2. compatible with all consumers
      1. `npx @pactflow/swagger-mock-validator provider_contracts/products_v1.0.4.yml ./consumer_contracts/pact_bdc_v1.0.0.json`
      2. `npx @pactflow/swagger-mock-validator provider_contracts/products_v1.0.4.yml ./consumer_contracts/pact_bdc_v1.0.1.json`
      3. `npx @pactflow/swagger-mock-validator provider_contracts/products_v1.0.4.yml ./consumer_contracts/pact_bdc_v1.0.3.json`
7. Scenario 7 - provider removes support of legacy endpoint - consumer/provider compatible
   1. `products_v1.0.5.yml` - remove /product
   2. `npx @pactflow/swagger-mock-validator provider_contracts/products_v1.0.5.yml ./consumer_contracts/pact_bdc_v1.0.1.json`
   3. `npx @pactflow/swagger-mock-validator provider_contracts/products_v1.0.5.yml ./consumer_contracts/pact_bdc_v1.0.3.json`

<details>
    <summary>Initial Pact File <a href="./consumer_contracts/pact_bdc_v1.0.0.json">Link</a></summary>

```json
{
  "consumer": {
    "name": "pactflow-example-consumer"
  },
  "provider": {
    "name": "pactflow-example-provider"
  },
  "interactions": [
    {
      "description": "a request to get a product",
      "providerState": "a product with ID 10 exists",
      "request": {
        "method": "GET",
        "path": "/product/10",
        "headers": {
          "Authorization": "Bearer 2019-01-14T11:34:18.045Z"
        },
        "matchingRules": {
          "$.headers.Authorization": {
            "match": "type"
          }
        }
      },
      "response": {
        "status": 200,
        "headers": {
          "Content-Type": "application/json; charset=utf-8"
        },
        "body": {
          "id": "10",
          "type": "CREDIT_CARD",
          "name": "28 Degrees"
        },
        "matchingRules": {
          "$.headers.Content-Type": {
            "match": "regex",
            "regex": "application\\/json;?.*"
          },
          "$.body": {
            "match": "type"
          }
        }
      }
    },
    {
      "description": "a request to get a product",
      "providerState": "a product with ID 11 does not exist",
      "request": {
        "method": "GET",
        "path": "/product/11",
        "headers": {
          "Authorization": "Bearer 2019-01-14T11:34:18.045Z"
        },
        "matchingRules": {
          "$.headers.Authorization": {
            "match": "type"
          }
        }
      },
      "response": {
        "status": 404,
        "headers": {}
      }
    },
    {
      "description": "a request to get all products",
      "providerState": "products exist",
      "request": {
        "method": "GET",
        "path": "/products",
        "headers": {
          "Authorization": "Bearer 2019-01-14T11:34:18.045Z"
        },
        "matchingRules": {
          "$.headers.Authorization": {
            "match": "type"
          }
        }
      },
      "response": {
        "status": 200,
        "headers": {
          "Content-Type": "application/json; charset=utf-8"
        },
        "body": [
          {
            "id": "10",
            "type": "CREDIT_CARD",
            "name": "28 Degrees"
          }
        ],
        "matchingRules": {
          "$.headers.Content-Type": {
            "match": "regex",
            "regex": "application\\/json;?.*"
          },
          "$.body": {
            "min": 1
          },
          "$.body[*].*": {
            "match": "type"
          }
        }
      }
    }
  ],
  "metadata": {
    "pactSpecification": {
      "version": "2.0.0"
    }
  }
}
```

</details>

<details>
    <summary>Initial OAS Contract <a href="./provider_contracts/products_v1.0.0.yml">Link</a></summary>

```yaml
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
            "application/json; charset=utf-8":
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
            "application/json; charset=utf-8":
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
                      # name: "pizza"
                      # version: "1.0.0"
                      # see https://github.com/apiaryio/dredd/issues/1430 for why
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
            "application/json; charset=utf-8":
              schema:
                $ref: "#/components/schemas/Product"
              examples:
                application/json:
                  value:
                    id: "1234"
                    type: "food"
                    price: 42
                    # name: "pizza"
                    # version: "1.0.0"
                    # see https://github.com/apiaryio/dredd/issues/1430 for why
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

</details> -->
