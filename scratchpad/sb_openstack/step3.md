## Design - Governance & Standardisation

It would be prudent of us to design API' that are secure, consistent and useful.

Stoplight Spectral provides an open-source API style guide enforcer and linter which can be used as a generic ruleset engine on any JSON or YAML data, but was built with OpenAPI, AsyncAPI, and JSON Schema in mind. 

You can use Spectral rules to target API descriptions for quality improvement or enforce API Style Guide rules, such as naming conventions for OpenAPI models or prohibiting integers in URLs.

API description formats like OpenAPI can be permissive and vague. Beginner API designers can struggle to know what to do, and experienced API designers can easily forget.

It's easy to create valid description documents that are not very useful, and end up looking broken in documentation tools, or not providing enough validation keywords to be useful for contract testing. Spectral helps you follow best practices in order to create high-quality API descriptions.

Spectral can be downloaded as a CLI binary for macOS, Linux or Windows, or installed as an NPM/Yarn package with a CLI and a JavaScript API. 

You can bake it into your existing tooling, run it in Continuous Integration, use it in any workflow you like. Let's take a look at one of them.

## Lint the OpenAPI document with Stoplight Spectral

Spectral, being a generic YAML/JSON linter, needs a [ruleset](https://github.com/stoplightio/spectral?tab=readme-ov-file#1-create-a-local-ruleset) to lint files. A ruleset is a JSON, YAML, or JavaScript/TypeScript file (often the file is called .spectral.yaml for a YAML ruleset) that contains a collection of rules, which can be used to lint other JSON or YAML files such as an API description.

First we define our local ruleset.

We then run Stoplight Spectral locally with Docker, pulling the image from Dockerhub.

We tell spectral where to locate the OpenAPI description and the location of the ruleset

   1. `make create_spectral_default_ruleset`{{exec}}
   2. `make openapi_lint_spectral`{{exec}}

Any violations are shown here, allowing us to rectify the changes, and re-validate. This ability to provide fast-feedback can be used at authoring time, as well as being integrated into Continuous Integration, meaning that its caught early on rather than causing issues to consumers and users of the API description.

### Check

Before moving to the next step, check the following:

1. You have been able to run `spectral` locally
2. You noted some OpenAPI validation errors
