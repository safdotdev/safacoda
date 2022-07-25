## Testing the consumer

Now that we have our basic consumer code base, it's time to write our first Pact test!

Pact implements a specific type of integration test called a contract test. Martin Fowler defines it as follows:

> An integration contract test is a test at the boundary of an external service verifying that it meets the contract expected by a consuming service — [Martin Fowler](https://martinfowler.com/bliki/IntegrationContractTest.html)

Create the pact test:

Look at filename: `consumer.pact.spec.js`:

There's a lot here, so let's break it down a little.

1. Import the appropriate library - this will differ depending on language
2. Configure Pact. The name of the consumer and provider is important, as it uniquely identifies the applications in Pactflow
3. Here we setup some Pact lifecycle hooks.
   - First we run `setup()`{{}} before all of the tests run to start the Pact runtime).
   - We also configure two other lifecycle hooks to `verify()`{{}} that the test was successful and write out the pact file
   - We call `finalize()`{{}} when the suite is finished. This specific step will vary depending on which language you use
4. _Arrange_: we tell Pact what we're expecting our code to do and what we expect the provider to return when we do it
5. _Act_: we configure our API client to send requests to the Pact mock service (instead of the real provider) and we execute the call to the API
6. _Assert_: we check that our call to `getProduct(...)`{{}} worked as expected. This should just do what a regular unit test of this method does.

### Run the test

`npm run test:consumer`

It should have created the following file:

`cat pacts/*.json`

### Check

Before moving to the next step, check the following:

1. You could run the pact test with `npm run test`
2. There is a contract file that has been created in the `pacts` folder
