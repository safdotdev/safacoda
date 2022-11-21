## Setup a locally running Pact Broker

### Prerequisites

- Pact Broker Application
- Postgres Database

## Lets get a Pact Broker

Now we have a passing test locally on the consumer side, and we have verified it on the provider side, we should now publish these to a Pact Broker to get the full benefits of contract testing.

1. `curl https://rebrand.ly/getpact -Lso - | bash -s -- broker deploy mybroker 8000`{{exec}}
2. It will take a little while to download the Docker images for your Pact Broker, and Postgres database.
3. After a short while, a the new web interface will be available.
4. Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents.
5. You can check the Docker logs for the Pact Broker, `docker logs mybroker_pact_broker_1`{{exec}}
6. Restart the container if there was any issues `docker restart mybroker_pact_broker_1`{{exec}}