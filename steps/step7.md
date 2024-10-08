# Deploy the consumer

Now that the provider is in production, and has satisfied the needs of the consumer, we can once again check if it's safe to release the consumer by running

`npm run can-deploy:consumer`

This should now pass:

```
> npx pact-broker can-i-deploy --pacticipant katacoda-consumer --version 1.0.0-someconsumersha --to-environment prod

Computer says yes \o/

CONSUMER          | C.VERSION             | PROVIDER          | P.VERSION             | SUCCESS?
------------------|-----------------------|-------------------|-----------------------|---------
katacoda-consumer | 1.0.0-someconsumersha | katacoda-provider | 1.0.0-someprovidersha | true

All required verification results are published and successful
```

Now we may release our consumer application to production:

`npm run deploy:consumer`

![second consumer pipeline run](./assets/consumer-run-2.png)

## Webhooks

You can see a `contract_published` event when a Pact is published. With Webhooks, we have hook into these events and configure the providers verification step, when publishing a consumer pact. This will give you accurate and up-to-date information when the consumer calls can-i-deploy.

Additionally we can report failures and verifications to Slack and various other systems.

See our [webhooks template library](https://docs.pact.io/pact_broker/webhooks/template_library)

## Check

Your dashboard should look something like this, where both your consumer and provider are marked as having been deployed to `Production`:

![pactflow dashboard - completed](./assets/pactflow-dashboard-complete.png)
