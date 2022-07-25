## The Consumer

Time to create our consumer code base.

In our project, we're going to need:

- A model (the `Product` class) to represent the data returned from the Product API
- A client (the `ProductApiClient`) which will be responsible for making the HTTP calls to the Product API and returning an internal representation of an Product.

Note that to create a Pact test, you do need to write the code that executes the HTTP requests to your service (in your client class), but you don't need to write the full stack of consumer code (eg. the UI).

### Scope of a Consumer Pact Test

Ideally, the Pact tests should be a unit test for your API client class, and they should just focus on ensuring that the request creation and response handling are correct. If you use pact for your UI tests, you'll end up with an explosion of redundant interactions that will make the verification process tedious. Remember that pact is for testing the contract used for communication, and not for testing particular UI behaviour or business logic.

Usually, your application will be broken down into a number of sub-components, depending on what type of application your consumer is \(e.g. a Web application or another API\). This is how you might visualise the coverage of a consumer Pact test:

![Scope of a consumer Pact test](./assets/consumer-test-coverage.png)

Here, a _Collaborator_ is a component whose job is to communicate with another system. In our case, this is the `API` class communicating with the external `Product API` system. This is what we want our consumer test to inspect.

### Lets look at our project

We need some dev dependencies to run our pact tests:

1. A unit testing framework
2. Pact for our API assertions

### Create our Product Model

Now that we have our basic project, let's create our `Product` domain model:

Take a look at filename: `product.js`:

### Create our Product API Client

Lastly, here is our API client code. This code is responsible for fetching products from the API, returning a `Product`:

Take a look at: `api.js`:

This class, and it's methods, will be the target of our Pact test(s).
