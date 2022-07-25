# Publish to Pactflow

Now that we have created our contract, we need to share the contract to our provider. This is where Pactflow comes in to the picture. This step is referred to as "publishing" the pact.

1. Go to Pactflow and copy your [read/write API Token](https://docs.pactflow.io/#configuring-your-api-token)
1. Export these two environment variables into the terminal, being careful to replace the placeholders with your own values:

   ```
   export PACT_BROKER_BASE_URL=https://YOUR_PACTFLOW_SUBDOMAIN.pactflow.io
   export PACT_BROKER_TOKEN=YOUR_API_TOKEN
   ```

1. `npm run publish`
1. Go to your Pactflow dashboard and check that a new contract has appeared

Your dashboard should look something like this:

![pactflow-dashboard-unverified](./assets/pactflow-dashboard-unverified.png)

Note the pact is currently "unverified" because the provider has ever confirmed it can fulfill the contract.

When we upload our pact, we also specify

- A [branch](https://docs.pact.io/pact_broker/branches)
- A [Consumer Version number](https://docs.pact.io/getting_started/versioning_in_the_pact_broker#consumer-application-versions)

The consumer version number should either be or contain the commit (ie. the git SHA or equivalent for your version control system) so we can identify a particular fixed version of code.

We will use [Recording deployments and releases](https://docs.pact.io/pact_broker/recording_deployments_and_releases)
to indicate which environment an application is in at any given time.

## Deploy

So we've created our consumer, published the contract and now it's time to deploy to production!

Before we do, however, we can check if this is safe to do:

`npm run can-deploy:consumer`

You should see the following output:

```
> npx pact-broker can-i-deploy
    --pacticipant katacoda-consumer
    --version 1.0.0-someconsumersha --to-environment prod

NO

```

Oh no! We can't deploy yet, because our Provider has yet to be created, let alone confirm if it can satisfy our needs.

The `can-i-deploy` command is an important part of a CI/CD workflow, adding stage gates to prevent deploying incompatible applications to environments such as production.

This diagram shows an illustrative CI/CD pipeline as it relates to our progress to date:

![first consumer pipeline run](./assets/consumer-run-1.png)

## Check

There should be a contract published in your Pactflow account before moving on
