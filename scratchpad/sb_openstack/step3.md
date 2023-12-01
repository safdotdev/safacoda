## Design - Swagger Editor

In our last step, we pulled in an API Description, that was previously created. This document is stored in `openapi/openapi.yaml`.

We mentioned that consuming it from the command line wasn't the nicest experience. What if we had a nicer way to view and edit our API description? Even better still, what if we could get feedback to ensure that the description
we are creating adheres to an OpenAPI specification. 

Swagger Editor allows you to describe, and document your API in a free open source editor which supports multiple API specifications and serialization formats.

It offers an easy way to get started with the OpenAPI Specification (formerly known as Swagger) as well as the AsyncAPI specification, with support for Swagger 2.0, OpenAPI 3.*, and AsyncAPI 2.* versions.

## Flavours

There are two flavours of Swagger Editor. We will introduce both.

### Swagger Editor

- Runs Anywhere
  - The Editor works in any development environment, be it locally or in the web
- Smart Feedback
  - Validate your syntax for OAS-compliance as you write it with concise feedback and error handling
- Instant Visualization
  - Render your API specification visually and interact with your API while still defining it
- Intelligent Auto-completion
  - Write syntax faster with a smart and intelligent auto-completion
- Fully Customizable
  - Easy to configure and customize anything, from line-spacing to themes
- All About Your Build
  - Generate server stubs and client libraries for your API in every popular language

### The Next Swagger Editor

![newSwaggerEditor](https://static1.smartbear.co/swagger/media/blog/swagger-editor-blog_575x300.png?ext=.png)

The next Swagger Editor, which we will refer to throughout this tutorial as swagger editor next, bring all the features from the original Swagger Editor plus support for AsyncAPI and JSON Schema.

This ground-up rewrite builds upon our multi-specification core, [Swagger ApiDOM](http://github.com/swagger-api/apidom), which provides a single, unifying structure for describing APIs across API description language and serialization formats. We'll share more information and context on Swagger ApiDOM soon, so stay tuned!

You can read more about the next Swagger Editor [here] in a blog post by fellow SmartBear Developer Relations member Frank Kilcommins, who is our resident API technical evangelist.

## Contributing

![OpenSourceSwagger](https://static1.smartbear.co/swagger/media/images/homepage/open-source-swagger.svg)

The Swagger Editor is just one open source project in the thousands that exist in the Swagger ecosystem.

The source code is publicly hosted on GitHub, and you can start contributing to the open source Swagger Editor project.

[View Swagger on GitHub](https://github.com/swagger-api)

## How can I get my hands on it?

### Hosted - Swagger Editor

Swagger Editor is hosted by SmartBear and served for free at [https://editor.swagger.io](https://editor.swagger.io).

👉🏼 [https://editor.swagger.io](https://editor.swagger.io).

1. Load our sample OpenAPI document from `openapi/openapi.yaml`
      1. File -> Import URL
      2. Paste the url 👉🏼 `https://raw.githubusercontent.com/smartbear-devrel/swaggerhub-pactflow/main/oas/swagger.yaml`
2. If you are running locally, you can import from File
      1. File -> Import File
      2. Select the file 👉🏼 `openapi/openapi.yaml`

### Hosted - Swagger Editor Next

👉🏼 [https://editor-next.swagger.io](https://editor-next.swagger.io).

By default, Swagger Editor Next loads an AsyncAPI definition.

1. Load our sample OpenAPI document from `openapi/openapi.yaml`,
      1. File -> Import URL
      2. Paste the url 👉🏼 `https://raw.githubusercontent.com/smartbear-devrel/swaggerhub-pactflow/main/oas/swagger.yaml`
2. If you are running locally, you can import from File
      1. File -> Import File
      2. Select the file 👉🏼 `openapi/openapi.yaml`

### Locally - Swagger Editor

We will run Swagger Editor locally with Docker, pulling the image from Dockerhub.

We will then mount a volume containing our OpenAPI description into the Docker container.

Finally we will pass an environment variable, telling the editor, to load our sample OpenAPI description by default.

1. 👉🏼 `make do_swagger_editor`{{exec}}
2. If running in the Killercoda tutorial, click [here]({{TRAFFIC_HOST1_8081}})
3. If running on your local machine, visit `http://localhost:8081`
   1. 👉🏼 `make view_swagger_editor`{{exec}}

### Locally - Swagger Editor Next

We will run Swagger Editor locally with Docker, pulling the image from Dockerhub.

We don't have the ability to pass in environment variables, with the Docker image, so once we have our running container, we will load the file manually.

1. 👉🏼 `make do_swagger_editor_next`{{exec}}
2. If running in the Killercoda tutorial, click [here]({{TRAFFIC_HOST1_8082}})
3. If running on your local machine, visit `http://localhost:8082`
   1. 👉🏼 `make view_swagger_editor_next`{{exec}}
4. Import our sample OpenAPI Description
      1. File -> Import File
      2. Select the file 👉🏼 `openapi/openapi.yaml`

### Check

Before moving to the next step, check the following:

1. You have been able to run `swagger-editor` locally
2. You have been able to run `swagger-editor-next` locally
