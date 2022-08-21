Now that everything is started.

Be sure you are in the _aggregator_ directory.

`cd ~/cdc-with-k8s/aggregator`{{execute}}

Verify the pacts on the producer side.

`./gradlew pactVerify`{{execute}}

<img align="right" src="./assets/broken.jpg" width="200">
**`BUILD FAILED`**

You will see that the verification failed. **This shows us that a consumer disagrees with the producer. This disagreement is fantastic because it's unveiling a defect _before_ it rolls further to production.**

If you inspect all the percentCases fields from the producer, they are all zero.

`curl https://[[HOST_SUBDOMAIN]]-30103-[[KATACODA_HOST]].environments.katacoda.com/countries/percapita | jq . | grep percentCases`{{execute}}

The consumer contracts all expect the percentage of infection values to be greater than zero. The consumer code is written with these rules.

`expect(Number(response[0].percentCases)).toBeGreaterThan(0.0);`

`percentCases: term({ generate: "0.3333", matcher: "^([0-9]*[1-9][0-9]*(\.[0-9]+)?|[0]+\.[0-9]*[1-9][0-9]*)$" }),`

So for some reason, the producer is producing only zeros. A typical defect on any normal day.

<img align="right" src="./assets/alexanderpope.jpg" width="200">

> To err is Humane; to Forgive, Divine. -Alexander Pope

But in this case, let's not forgive and just fix the problem.
