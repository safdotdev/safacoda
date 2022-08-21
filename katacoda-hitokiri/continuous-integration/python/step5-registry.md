Various Kubernetes workflows will need access to one or more container registries. While public registries are commonly referenced, it does not make sense to shuttle images that are private to your organization over public networks. Instead, private registries keep all this pushing and pulling in a local registry.

There are many options for standing up a container registry. We prefer a pure Kubernetes solution and install a registry through the [stable Helm chart for Docker Registry](https://github.com/helm/charts/tree/master/stable/docker-registry#docker-registry-helm-chart).

## Install the Registry

First, add the stable chart repository.

`helm repo add stable https://kubernetes-charts.storage.googleapis.com`{{execute}}

Install the chart for a private container registry.

```bash
helm install registry stable/docker-registry \
  --version 1.9.4 \
  --namespace kube-system \
  --set service.type=NodePort \
  --set service.nodePort=31500
```{{execute}}

## Install Registry Proxies as Node Daemons

In the subsequent steps, the pipeline will build a container and deploy them to this registry. The Docker Engine on each Kubernetes node has tight security rules around pulling images from registries. Especially registries that are deemed as “insecure." Docker requires pulls to be SSL and with authentication. However, oftentimes you are just wanting to use the private registry within the cluster. The Docker engine will pull from a "localhost" registry without triggering its security precautions. We run a [kube-registry-proxy](https://github.com/helm/charts/blob/master/incubator/kube-registry-proxy/README.md) on each node in the cluster, exposing a port on the node (via the hostPort value), which Docker accepts since it is accessed by localhost.

The [kube-registry-proxy](https://github.com/helm/charts/blob/master/incubator/kube-registry-proxy/README.md) is available in this repo:

`helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator`{{execute}}

With the added repo, install the proxy daemons.

`helm install registry-proxy incubator/kube-registry-proxy \
  --version 0.3.2 \
  --namespace kube-system \
  --set registry.host=registry-docker-registry.kube-system \
  --set registry.port=5000 \
  --set hostPort=5000`{{execute}}

This proxy is deployed as a [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) on every node in your cluster. Internal to all the container engines in the cluster, the registry is now available as a service for pushing and pulling container images. Pods can pull images from the registry at http://localhost:5000 and the proxies resolve the requests to https://registry-docker-registry.kube-system:5000.

## Install Registry UI

It's always helpful to have a decent web interface in front of your container image registry. There are a few open solutions out there that all run as containers. This particular one, [joxit/docker-registry-ui](https://github.com/Joxit/docker-registry-ui), is solid and provides a clean interface. Merci beaucoup, [Jones Magloire](https://joxit.dev/).

`kubectl apply -f ~/registry-ui.yaml`{{execute}}

In a moment the new web interface will be available. Open the [registry web interface](
https://[[HOST_SUBDOMAIN]]-31000-[[KATACODA_HOST]].environments.katacoda.com/). Observe that the container list is empty (0 images). The pipeline you will define in the next steps will add a new container here.
