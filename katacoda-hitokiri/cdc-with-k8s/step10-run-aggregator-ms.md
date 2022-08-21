<img align="right" src="./assets/nicholas-bartos-CzZcuJABONQ-unsplash.jpg" width="275">
This microservice is called the Aggregator as it follows the common architecture pattern of an aggregator. It provides a single API gateway to access the other two microservice; world-pop and convid-19. The data from the two other microservices are merged into responses where COVID-19 data is merged with population data. With population data, you can get visibility in infection rates based on percapita.

** THIS DATA SHOULD NOT BE USED FOR ANYTHING OUTSIDE THE CONFINES OF THIS SCENARIO. **

Move to the _aggregator_ directory.

`cd ~/cdc-with-k8s/aggregator`{{execute}}

## Build microservice container image

Spring Boot with Gradle (or Maven) has a convenient task called _bootBuildImage_. Without having to write a Dockerfile this task will bundle the Java application into an optimized container image. Build and tag the  microservice container image.

`./gradlew bootBuildImage --imageName=localhost:5000/$(basename $PWD):0.0.1`{{execute}}

Push the container image to the private registry on your Kubernetes cluster.

`docker push localhost:5000/$(basename $PWD):0.0.1`{{execute}}

Inspect the registry to see the container image has been pushed.

`curl $REGISTRY/v2/_catalog | jq`{{execute}}

## Start microservice

Apply this manifest declaration to set up a Pod and Service for the microservice.

`kubectl apply -f ../cluster/$(basename $PWD).yaml`{{execute}}

The microservice will be running in a moment, so check it's status.

`kubectl get pods,deployments,services -l app=$(basename $PWD)`{{execute}}

## Verify microservice

In a few moments, the Deployment will be available at a NodePort. Explore the data with these rest calls.

`curl https://[[HOST_SUBDOMAIN]]-30103-[[KATACODA_HOST]].environments.katacoda.com/ping; echo`{{execute}}

List all the countries.

`curl https://[[HOST_SUBDOMAIN]]-30103-[[KATACODA_HOST]].environments.katacoda.com/countries | jq .`{{execute}}

Get a single country.

`curl https://[[HOST_SUBDOMAIN]]-30103-[[KATACODA_HOST]].environments.katacoda.com/countries/ind | jq .`{{execute}}

Get the top countries with the highest infections per capita.

`curl https://[[HOST_SUBDOMAIN]]-30103-[[KATACODA_HOST]].environments.katacoda.com/countries/percapita | jq .`{{execute}}

You can also try it [in your browser](https://[[HOST_SUBDOMAIN]]-30103-[[KATACODA_HOST]].environments.katacoda.com/countries/percapita).
