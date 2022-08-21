Create a namespace for the installation target.

`kubectl create namespace redis`{{execute}}

Add the chart repository for the Helm chart to be installed. You did this in the previous step, but it's no harm to attempt to add it twice.

`helm repo add bitnami https://charts.bitnami.com/bitnami`{{execute}}

With a known chart name, use the _install_ command to deploy the chart to your cluster.

`helm install my-redis bitnami/redis --version 10.7.16 --namespace redis`{{execute}}

This will name a new install called _my-redis_ and install a specific chart name and version into the _redis_ namespace. With the install command Helm will launch the required Deployments, ReplicaSets, Pods, Services, ConfigMaps, or any other Kubernetes resource the chart defines.

Well written charts will present notes as part of the installation instructions. The notes will provide helpful information on how to access the new services. We'll follow these notes in the next step, but first, view all the installed charts.

`helm list --all-namespaces`{{execute}}

or

`helm ls -n redis`{{execute}}

The installed `my-redis` chart should be listed.

## Chart Installation Information

For each chart deployed to the cluster its deployment information is maintained in a secret stored on the targeted Kubernetes cluster. This way multiple Helm clients can consistently list the installed charts on the cluster. The secrets are deployed to the namespace where the chart is deployed. The secret names have the _sh.helm._ prefix.

`kubectl get secrets --all-namespaces | grep sh.helm`{{execute}}

When you ask Helm for a list of charts:

`helm list -A`{{execute}}

then Helm will query Kubernetes for a list of secrets filtered for Helm.

`kubectl get secrets --all-namespaces --selector owner=helm`{{execute}}

For the Redis chart, you installed to the _redis_ namespace you can see the secret information about the deployment.

`kubectl --namespace redis describe secret sh.helm.release.v1.my-redis.v1`{{execute}}

The next step will verify the deployment status.
