## Document

Now that we have design our OpenAPI file, describing our API, we want to share it with others, there are a couple of tools within SmartBears open-source toolset that can provide this.

We saw one in use in the Swagger Editor, on the right-hand side, and we will introduce a second into the mix. Which one you choose may depend on a variety of reasons, so I would advise reading the documentation to find out more.

## Swagger UI

[Swagger UI](https://swagger.io/tools/swagger-ui/) allows anyone — be it your development team or your end consumers — to visualize and interact with the API’s resources without having any of the implementation logic in place. It’s automatically generated from your OpenAPI (formerly known as Swagger) Specification, with the visual documentation making it easy for back end implementation and client side consumption.

- Dependency Free
  - Dependency FreeThe UI works in any development environment, be it locally or in the web
- Human Friendly
  - Allow end developers to effortlessly interact and try out every single operation your API exposes for easy consumption
- Easy to Navigate
  - Quickly find and work with resources and endpoints with neatly categorized documentation
- All Browser Support
  - Cater to every possible scenario with Swagger UI working in all major browsers
- Fully Customizable
  - Style and tweak your Swagger UI the way you want with full source code access
- Complete OAS Support
  - Visualize APIs defined in Swagger 2.0 or OAS 3.\*

## Stoplight Elements

[Stoplight Elements](https://stoplight.io/open-source/elements) provides Open-source API documentation building blocks which can be used to build highly customized, interactive API Docs with embeddable web components generated from OpenAPI documents

Whether you have an existing developer portal, or are working locally, you can use these components to add automatically-generated API reference documentation that fits in seamlessly.

- Delightful developer experience.
  - Help developers find and consume APIs faster with a customizable left navigation and three-column layout.
- Powered by standards.
  - Leverage OpenAPI and JSON Schema to create beautiful, templated documents for even the most dynamic payloads, and encourage reuse with $ref.
- Interactive API console.
  - Accelerate developer onboarding by letting them test requests and responses within the documentation.
- Code samples.
  - Streamline Integration by providing code samples in popular languages like Curl, Python, Ruby, Java, and many more.
- Enhanced markdown support.
  - Provide engaging guides and descriptions with Stoplight-flavored Markdown that gives the ability to add tabs, callouts, embed JSON examples, and much more.
- Easy to set up.
  - No build steps. Get started in minutes. Built on web components, it's as easy as adding a tag within your project, and can be used with any framework.

### Run it Locally - Swagger UI

We will run Swagger UI locally with Docker, pulling the image from Dockerhub.

We will then mount a volume containing our OpenAPI description into the Docker container.

Finally we will pass an environment variable, telling the editor, to load our sample OpenAPI description by default.

1. Swagger UI
   1. `make do_swagger_ui`{{exec}}
2. If running in the Killercoda tutorial, click [here]({{TRAFFIC_HOST1_8083}})
3. If running on your local machine, visit `http://localhost:8083`
   1. 👉🏼 `make view_swagger_ui`{{exec}}

### Run it Locally - Stoplight Elements

There are multiple ways to run Stoplight elements, in our example, we have a component in a html page, and we load in the Elements library via a script tag.

We are passing in a URL to a hosted OpenAPI description, to save having to serve the file locally.

1. If running in the Killercoda tutorial, find the file `openstack/elements.html`
   1. Right click on the file in the editor explorer view
   2. Select `Download`
   3. Open the downloaded file, it should open in your preferred browser.
2. If running on your local machine
   1. `make openapi_docs_elements`{{exec}}

### Check

Before moving to the next step, check the following:

1. You have been able to run `swagger-ui` locally
2. You have been able to run `stoplight-elements` locally
