It's helpful to have a container registry during the build, push, and deploy phases. There is no need to shuttle private images over the internet. Instead, we keep all this pushing and pulling in a local registry.

## Install registry

<img align="right" src="./assets/registry.png" width="200">

There are many options for standing up a container registry. We prefer a pure Kubernetes solution and install a registry through the [stable Helm chart](https://github.com/helm/charts/tree/master/stable/docker-registry#docker-registry-helm-chart).

Add the chart repository for the Helm chart to be installed.

`helm repo add stable https://kubernetes-charts.storage.googleapis.com`{{execute}}

Install the chart for a private container registry.

```bash
helm install registry stable/docker-registry \
  --version 1.9.4 \
  --namespace kube-system \
  --set service.type=NodePort \
  --set service.nodePort=31500
```{{execute}}

## Verify registry

The registry is now available as a service. It can be listed.

`kubectl get service --namespace kube-system`{{execute}}

Assign an environment variable to the common registry location.

`export REGISTRY=[[HOST_SUBDOMAIN]]-31500-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

It will be a few moments before the registry deployment reports it's _Available_.

`kubectl get deployments registry-docker-registry --namespace kube-system`{{execute}}

Once the registry is serving, inspect the contents of the empty registry.

`curl $REGISTRY/v2/_catalog | jq`{{execute}}

When it's running and healthy, you will see an empty list.

`{"repositories":[]}`

## Registry Proxy for localhost:5000

Docker tags require the address of the registry to be in the tag. If we push and pull from the registry, the registry name tag must be the same when we are on the client or within Kubernetes. Within your cluster, the registry is available at localhost:5000. Use a port-forwarding command to make this client's localhost:5000 to be the same registry.

`kubectl port-forward -n kube-system service/registry-docker-registry 5000:5000 > /dev/null &`{{execute}}

This port forwarding will run in the background for the remainder of this scenario.

Now you can access the registry via localhost.

`curl http://localhost:5000/v2/_catalog | jq .`{{execute}}

This means when you push to localhost:5000 your container images will be routed to the private registry running as a service on Kubernetes.

But what happens in the Pod specification when you want to pull the image using the tag localhost:5000? We can add a proxy that runs as a DaemonSet that will resolve localhost:5000 to the registry whenever a Pod requests a container from localhost:5000. Install the proxy.

`helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator`{{execute}}

With the added repo, install the proxy daemons.

`helm install registry-proxy incubator/kube-registry-proxy \
  --version 0.3.2 \
  --namespace kube-system \
  --set registry.host=registry-docker-registry.kube-system \
  --set registry.port=5000 \
  --set hostPort=5000`{{execute}}

For mature environments, you would have an official host name with a load balancer and an ingress that would resolve to a hardened registry service, albeit still running on Kubernetes.

Later, you will see docker push commands and YAML container references both using http://localhost:5000.
