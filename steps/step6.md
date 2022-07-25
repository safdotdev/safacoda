# Testing (Verify) the provider

Now that we published our contract, we can have the provider verify it each time the provider build runs, to prevent introducing breaking changes to their consumers. This is referred to as "provider verification".

_NOTE: Credentials from the previous step will be required for this step to run._

#### Run the Provider tests

This step involves the following:

1. Starting the API \(line 5\)
1. Telling Pact to use the contracts stored in Pactflow and where the Product API will be running \(lines 8-16\)
1. Running the Provider verification task \(line 18\)

Take a look at the filename: `provider.pact.spec.js`

we can run it with `npm run test:provider`

## Deploy

Now we've created our provider and confirmed it can meet the needs of its consumers, we can deploy it to production!

As with the consumer, we can first check if this is safe to do

`npm run can-deploy:provider`

Great! Because the Provider meets the needs of the consumer (and the consumer is not yet in production) it is safe to do.

Deploy the provider:

`npm run deploy:provider`

_REMINDER: The `can-i-deploy` command is an important part of a CI/CD workflow, adding stage gates to prevent deploying incompatible applications to environments such as production_

This diagram shows an illustrative CI/CD pipeline as it relates to our progress to date:

![first provider pipeline run](./assets/provider-run.png)

## Check

Your dashboard should look something like this, where your provider has been marked as having been deployed to `Production`:

![pactflow-dashboard-provider-verifier](./assets/pactflow-dashboard-provider-verified-prod.png)
