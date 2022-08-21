Just about anything can be packaged into a container. Python applications in containers are ideal and many Python developers found this as a convienent way to packager and deliver their applications. Here is a simple Dockerfile that describes a very simple packaging.

## Bloated Container

`ccat -l dockerfile Dockerfile-bloated`{{execute}}

Using this definition, build the container image.

`docker build -t scenario/mountains-bloated:0.0.1 -f Dockerfile-bloated .`{{execute}}

When it's done building the container image, run the application.

`docker run -d -p 8090:8080 scenario/mountains-bloated:0.0.1`{{execute}}

The microservice is now running at port 8090.

`curl localhost:8090 | jq`{{execute}}

Inspect the size of the container image.

`docker images --filter 'label=scenario=python-pipelining'`{{execute}}

Notice the image size is ~370MB. This is a very small Python application and producing a container this large is excessive.

Also, linters will not be happy with the Dockerfile source.

`docker run --rm -i hadolint/hadolint < Dockerfile-bloated`{{execute}}

Many developers have placed Python in containers this way and stopped here. For testing and developing or running this as a standalone container, it works and it's perfectly fine. But when you start to explore deploying a large collection of container to Kubernetes, this waste can add up quickly. For the distillation pattern, it's not just the size of the container image that matters. Other resources can be wasted such as execution time, memory consumption, high coupling, and exposing attack vectors. For now we will concentrate on the image size as it tends to point us at problems in obtaining high cohesion for our containers.

## Builder Pattern

One technique applied to create smaller container images is the builder pattern. With the advent of multi-stage Dockerfiles, introduced with Docker 17.01, the building steps can now be modularized. Each build stage can use tools and dependencies to build up artifacts for the final image layer, allowing all the tools and associated dependencies not needed at runtime to be discarded. We evolved the previous Dockerfile into a multi-stage, builder pattern format.

`ccat -l dockerfile Dockerfile-slim`{{execute}}

We also took this opportunity to address the linting advice.

`docker run --rm -i hadolint/hadolint < Dockerfile-slim`{{execute}}

Notice the warnings are gone and the specific gcc compiler version was provided instead of _latest_. Specifying specific versions in code significantly increases trust in idempotency over time.

Using this multi-stage definition, build the container image.

`docker build -t scenario/mountains-slim:0.0.1 -f Dockerfile-slim .`{{execute}}

When it's done building the container image, run the application.

`docker run -d -p 8091:8080 scenario/mountains-slim:0.0.1`{{execute}}

The microservice is now running at port 8091.

`curl localhost:8091 | jq`{{execute}}

Inspect the size of the container image.

`docker images --filter 'label=scenario=python-pipelining'`{{execute}}

Notice the image size has been reduce to 217MB. By adding the multi-stage building of the same application we were able to reduce the size of the container image by 153MB! This smaller image can now be pushed, pulled and cached with much less cost and increased speed, yet continue to support the application features.

In the next step, let's see if we can squeeze a bit more out of the container image while maintaining the same functionality.
