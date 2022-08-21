<img align="right" src="./assets/csse.png" width="275">

This is a Spring Boot based Microservice that reads COVID-19 metrics from a public CSV file. This microservice offers REST endpoints to get the data from the `/metrics`. Data is provided in the JSON format.

This data is aggregated from various other public sources and is curated by [Johns Hopkins University Center for Systems Science and Engineering (JHU CSSE)](https://systems.jhu.edu/) in this public [Git repo(https://github.com/CSSEGISandData/COVID-19). The data is updated daily.

Move to the _covid-19_ directory.

`cd ~/cdc-with-k8s/covid-19`{{execute}}

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

`curl https://[[HOST_SUBDOMAIN]]-30102-[[KATACODA_HOST]].environments.katacoda.com/ping; echo`{{execute}}

`curl https://[[HOST_SUBDOMAIN]]-30102-[[KATACODA_HOST]].environments.katacoda.com/metrics | jq .`{{execute}}

You can also try it [in your browser](https://[[HOST_SUBDOMAIN]]-30102-[[KATACODA_HOST]].environments.katacoda.com/metrics).
