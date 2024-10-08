# Publish the provider contract to Pactflow

Now that we have created and verified our provider contract, we need to share the contract to our consumers. This is where Pactflow comes in to the picture. This step is referred to as "publishing" the provider contract.

The publishing step takes two key components:

- The provider contract itself (in our case, the OAS document)
- The test results (in our case, the Dredd output and whether or not it passed)

This information will be helpful later on, when we need to check compatibility with its consumers.

1. Go to Pactflow and copy your [read/write API Token](https://docs.pactflow.io/#configuring-your-api-token)
1. Export these two environment variables into the terminal, being careful to replace the placeholders with your own values:

   ```
   export PACT_BROKER_BASE_URL=https://YOUR_PACTFLOW_SUBDOMAIN.pactflow.io
   export PACT_BROKER_TOKEN=YOUR_API_TOKEN
   ```
2. `echo $PACT_BROKER_BASE_URL`{{execute}} This should return your base url
3. `echo $PACT_BROKER_TOKEN`{{execute}} This should return your token, you can now move on
4. `npm run publish`{{execute}}
5. Go to your Pactflow dashboard and check that a new contract has appeared

Your dashboard should look something like this:

![pactflow-dashboard-unverified](./assets/dashboard-provider-only.png)

## Don't have a Pactflow account?

If you don't have a Pactflow account, you can publish a [test broker](https://test.pactflow.io).

```
export PACT_BROKER_BASE_URL=https://test.pactflow.io
export PACT_BROKER_TOKEN=129cCdfCWhMzcC9pFwb4bw
```{{execute}}

If you use this account, note that you won't have access to the UI.

## Check

There should be a contract published in your Pactflow account before moving on.
