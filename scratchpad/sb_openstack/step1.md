## Setup

We will use a demonstration OpenAPI description, for our example.

Running the following command will

- Create a directory called `openapi`
- Retrieve an example OpenAPI description from [GitHub](https://github.com/SmartBear-DevRel/swaggerhub-pactflow/blob/main/oas/swagger.yaml)
- Setup a `.gitgnore` file used to exclude some files from being commited to source control.

👉🏼 `make setup`{{exec}}

You can check the contents of the OpenAPI description with the following command

👉🏼 `cat openapi/openapi.yaml`{{exec}}

It isn't so easy to read from a terminal, but that will lead us onto our first tool. Swagger Editor.

### Check

Before moving to the next step, check the following:

1. There is a directory called `openapi/openapi.yaml` in your workspace.
