There are many workflows around Kubernetes that need access to one more container registries. While public registries are commonly referenced there is privacy concerns and no need to shuttle private images over public networks. Instead, private registries keep all this pushing and pulling in a local registry.

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

The registry is now available as a service. It can be listed.

`kubectl get service --namespace kube-system`{{execute}}

The Docker tag, push and pull commands must all have the same host name for the image. Docker also requires SSL access, so it's necessary to consistently refer to the registry from the command-line and from within the cluster. In this scenario case we can simply use 127.0.0.0. Use port-forward to expose the registry.

```bash
kubectl port-forward --namespace kube-system \
$(kubectl get po -n kube-system | grep registry-docker-registry | \
awk '{print $1;}') 5000:5000 &
```{{execute}}

Assign an environment variable to the common registry location.

`export REGISTRY=127.0.0.1:31500`{{execute}}

It will be a few moments before the registry deployment reports it's _Available_ with a _1_.

`kubectl get deployments registry-docker-registry --namespace kube-system`{{execute}}

Once the registry is serving, inspect the contents of the empty registry.

`curl $REGISTRY/v2/_catalog | jq`{{execute}}

When it's running and healthy, you will see an empty list.

`{"repositories":[]}`
