*Drift verifies that your API actually behaves the way your OpenAPI contract says it should.*

APIs evolve. Implementations change. Edge cases emerge.

But the specification your consumers rely on often stays the same.

Eventually, the two diverge.

This is **API Drift** — when your API implementation no longer matches its contract.

When drift happens:

- integrations break unexpectedly
- documentation becomes unreliable
- client SDKs behave incorrectly
- releases introduce unintended breaking changes

These issues are often discovered late, after deployment, when they are harder and more expensive to fix.

Drift helps prevent this problem. It runs real requests against your API and validates the responses against your OpenAPI specification.

![Drift verification workflow](/assets/drift.gif)

## Understanding API Drift

API Drift occurs when your API's implementation—the actual code—no longer matches its specification (the OpenAPI file).

### The Problem

As APIs evolve, developers might add fields, change data types, or modify status codes. If the documentation isn't updated simultaneously, client applications relying on that spec will break.

### The Drift Solution

Project Drift is a **spec-first** testing tool. It ensures alignment through three core mechanisms:

1. **Specification as Source of Truth**: Tests are mapped directly to your OpenAPI endpoints.
2. **Deep Schema Validation**: Drift automatically validates response bodies against the JSON schemas defined in your spec.
3. **Repeatable CI/CD Validation**: By running Drift in your automation pipeline, you catch drift before it reaches production.

#### Why this matters

Teams often want confidence that their API “works correctly”, but this can refer to many different concerns:

1. Does the API conform to its contract?
1. Does the system behave correctly when the API is exercised?
1. Do multi-step workflows work as expected?
1. Do downstream systems respond correctly?

Drift rigorously addresses #1. Functional, integration, and E2E tests address #2–4.

This distinction is essential for establishing a stable, maintainable testing strategy.

### What Drift Is Designed to Test

Drift performs **contract conformance testing** — fast, deterministic checks that validate whether an API implementation matches its published specification.

Drift validates:

- request/response structure
- status codes
- headers and media types
- JSON schema conformance
- examples from the OpenAPI document
- path, query, and header parameter constraints
- **narrow, controlled statefulness** (e.g., verifying 200 vs 404 for known IDs)

Drift supports limited, operation‑scoped stateful testing where the state is **local, controlled, and does not depend on earlier test execution**. See: [Testing APIs With State Dependencies](https://pactflow.github.io/drift-docs/docs/tutorials/testing-with-state)

These checks are fast, isolated, and highly repeatable — ideal for local development, CI pipelines, and production validation.

### What Drift Is Not Designed to Test

Drift does not validate broader system behaviour, including:

- multi-step workflows requiring prior operations
- scenario sequencing (“set system state then test”)
- business rules or domain logic
- system‑wide side effects (DB updates, events, queues)
- cross-service or distributed behaviours

These concerns belong to functional, integration, or E2E testing.

## Why Teams Like Drift

Drift provides:

- **Spec-driven**: OpenAPI is the source of truth
- **CLI-first**: Suitable for local use and CI pipelines
- **Declarative**: Deterministic, versioned-controllable test suites
- **Scriptable**: Lua hooks for setup, validation and advanced workflows
- **Extensible**: Plugin architecture for different verification or reporting needs
- **Flexible**: Run standalone or embed into existing test frameworks
- **Contract-aware**: Integrates with PactFlow for contract testing workflows

This makes the contract executable as part of a continuous verification workflow.

