`ccat -l dockerfile Dockerfile-alpine`{{execute}}

Using this definition, build the container image.

`docker build -t scenario/mountains-alpine:0.0.1 -f Dockerfile-alpine .`{{execute}}

When it's done building the container image, run the application.

`docker run -d -p 8092:8080 scenario/mountains-alpine:0.0.1`{{execute}}

The microservice is now running at port 8090.

`curl localhost:8092 | jq`{{execute}}

Inspect the size of the container image.

`docker images --filter 'label=scenario=python-pipelining'`{{execute}}

Notice the image size is even smaller at ~144MB. A 39% reduction from the original bloated size.

Two other projects that could take this further are GraalVM and WebAssembly. It's early days for these ideas, but more on that may be added to this scenario at a later date.

## Running on Kubernetes

So far you have just built and run the microservice in a container locally. No microservice is an island. Your modularized and distributed application can be comprised of dozen, hundreds or even thousands of containers. This is why we wanted to reduce the image size of just this one containerized microservice. 

Now that you have a container, you certainly push it to a registry and have Kubernetes pull and run it in a Pod. However, most things deployed to Kubernetes should be infrastructure-as-code ([IaC](https://en.wikipedia.org/wiki/Infrastructure_as_code)), including the recipes that continuously deliver application updates as we fix and evolve our applications. This CI/CD process is often captured in source code for CI/CD pipelines. With Tekton, your pipelines are declared in code. For this scenario, the code is in the `pipelines` directory.

In the remaining steps, we will take this idea further and focus on a build pipeline that can gather the source, build the container, and deliver the microservice to Kubernetes.
