
Hopefully, you can now start to see how changing the perspective of test by embracing the consumer perspectives can be a powerful testing technique, especially for Microservices.

With an established library of contacts, a producer writer can have much more confidence when making adjustments to the API that others consumer. With any change they can run pactVerify, to help understand the impact of changes to their consumers.

Consumers can work with customer requirements and evolving APIs by mocking up new communication scenarios. Those new contacts can be published and verified against their providers. The Pacts provide opportunities for conversations and understanding impacts of change while maintaining a clean separation between the producers and consumers.

## Lessons Learned ##

With these steps you have learned how to:

- &#x2714; set up a Pact Broker on Kubernetes
- &#x2714; write a consumer that defines and publishes Pact contracts
- &#x2714; deploy and run a few Spring Boot microservices on Kubernetes
- &#x2714; connect microservices to a database and public data source
- &#x2714; verify the consumer pacts against a producer
- &#x2714; find API defects and fix them

## References ##

- [Consumer-Driven Contracts: A Service Evolution Pattern, Ian Robinson, 2006](https://martinfowler.com/articles/consumerDrivenContracts.html)
- [Thoughtworks Tech Radar on Pact](https://www.thoughtworks.com/radar/techniques/consumer-driven-contract-testing)
- [Pact Foundation](https://pact.io/)
- [Pact Broker](https://github.com/pact-foundation/pact_broker)
- [Marie Drake, Contract Testing with Pact.js and Jest](https://www.mariedrake.com/post/contract-testing-with-pact-js-and-jest)
- [Jest - delightful JavaScript Testing Framework](https://jestjs.io/)
- [jest-pact](https://github.com/pact-foundation/jest-pact)
- [Spring boot with Docker](https://spring.io/guides/gs/spring-boot-docker/)
- [Spring Boot in a Container](https://spring.io/blog/2018/11/08/spring-boot-in-a-container)
- [Spring Boot initializr](https://github.com/spring-io/initializr)
- [Gradle](https://gradle.org)
- [Multi-stage Dockerfile](https://docs.docker.com/develop/develop-images/multistage-build/)
- [Alpine](https://en.wikipedia.org/wiki/Alpine_Linux)
- [Alpine virtues: small, simple and secure](https://alpinelinux.org/about/)

------
<p style="width: 100%; text-align: center; padding: 1em; margin: 3em; margin-left: 10em; margin-right: 10em; border-; 1px; border-color: olive;  border-radius: 12px; border-style:outset">
<img align="left" src="./assets/jonathan-johnson.jpg" width="100" style="border-radius: 12px">
For a deeper understanding of these topics and more join <br>[Jonathan Johnson](http://www.dijure.com)<br> at various conferences, symposiums, workshops, and meetups.
<br><br>
<b>Software Architectures ★ Speaker ★ Workshop Hosting ★ Kubernetes & Java Specialist</b>
</p>
