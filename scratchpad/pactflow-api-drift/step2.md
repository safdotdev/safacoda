Getting Started 

## Install Drift

Drift is available as a standalone binary, and is language agnostic. It can be used to test any API, regardless of the implementation language or framework.

The simplest way to try Drift without installing anything globally is with `npx` (required node):

`npx -y @pactflow/drift --help`{{execute}}

If you prefer a global install (available across shells), install from npm, please do so, for this tutorial

`npm install -g @pactflow/drift`{{execute}}

`drift --help`{{execute}}

If you don't use node, or need more options, see our [Installation Guide](https://pactflow.github.io/drift-docs/docs/how-to/install) for manual installation, verification steps, and troubleshooting.

## Create your First Test Suite

Create a file named `drift.yaml` folder. We will point Drift to the Petstore OpenAPI definition and define a few simple operations to verify.

```
# yaml-language-server: $schema=https://download.pactflow.io/drift/schemas/drift.testcases.v1.schema.json
drift-testcase-file: v1
title: "Petstore API Verification"

sources:
  - name: petstore-oas
    # Use the remote Petstore API description
    uri: https://petstore3.swagger.io/api/v3/openapi.yaml
    # Or a local one
    # path: oad.yaml

plugins:
  - name: oas
  - name: json

operations:
  # Verify that the inventory can be retrieved
  getInventory_Success:
    target: petstore-oas:getInventory
    description: "Check if store inventory is accessible"
    expected:
      response:
        statusCode: 200

  # Verify fetching a pet by a specific ID
  getPetById_Success:
    target: petstore-oas:getPetById
    description: "Fetch details for pet ID 1"
    parameters:
      path:
        petId: 1
    expected:
      response:
        statusCode: 200

  # Verify fetching a pet by a specific ID
  getPetById_NotFound:
    target: petstore-oas:getPetById
    description: "Fetch details for pet ID 143"
    parameters:
      path:
        petId: 143
    expected:
      response:
        statusCode: 404
```{{copy}}


💡 __IDE Tip: The YAML Language Server comment at the top enables auto-completion and validation in your editor. As you type, you'll see suggestions for property names and valid values.__

## Run the Verifier

Run the drift verifier command. We will use the Petstore virtual server (https://petstore.swagger.io/v2/) as our target URL.

`cd /root/example-provider`{{execute}}

`drift verifier --test-files drift.yaml --server-url https://petstore.swagger.io/v2/`{{execute}}

## Viewing Test Results

Drift displays results in a clear table format:

```
─[ Summary ]───────────────────────────────────────────────────────────────────────────────────────────

Executed 1 test case (1 passed, 0 failed)
Executed 3 operations (3 passed, 0 failed, 0 skipped)
Execution time 1.288865209s
Setup time 72.192458ms

┌────────────────────────────┬────────────────────────────┬──────────────────────────────────┬────────┐
│ Testcase                   ┆ Operation                  ┆ Target                           ┆ Result │
╞════════════════════════════╪════════════════════════════╪══════════════════════════════════╪════════╡
│ Petstore API Test          ┆ getInventory_Success       ┆ petstore-oas:getInventory        ┆ OK     │
├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌-┼╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌-╌╌╌┼╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌---╌╌╌┼╌╌╌╌╌╌╌╌┤
│                            ┆ getPetById_Success         ┆ petstore-oas:getPetById          ┆ OK     │
├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌-╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌-╌╌╌┼╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌--╌╌╌┼╌╌╌╌╌╌╌╌┤
│                            ┆ getPetById_NotFound        ┆ petstore-oas:getPetById          ┆ OK     │
└────────────────────────────┴────────────────────────────┴──────────────────────────────────┴────────┘
```

Each row shows an operation, its target, and the result (OK or FAILED). The summary at the top tells you how many test cases and operations passed.

If a test fails, you'll see a Failures section with details about what went wrong. See [Debugging](https://pactflow.github.io/drift-docs/docs/how-to/debugging) for how to interpret and fix failures.

## What Happened Behind the Scenes

1. Source Loading: Drift fetched the `oas.yaml` from the remote URL.
1. Contract Mapping: It mapped your `getInventory_Success` operation to the `/store/inventory` endpoint in the spec.
1. Deep Validation: Drift executed the HTTP request and performed a full JSON schema validation on the response to ensure it matches the `Petstore` model.