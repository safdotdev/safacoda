Many common and publicly available open source projects can run on Kubernetes. Many of these projects offer containers that package these applications and vetted Helm charts for full production installations on Kubernetes.

Up until recently in 2020, all of the most commonly used public Helm charts were being lumped into a single Git repository for incubating and stable Helm charts. This idea of centralizing all charts in GitHub has since been abandoned, thankfully. There are too many charts now being maintained by many different organizations and projects. Every day more charts are being added to our community.

## Helm Hub

Now, the canonical source for Helm charts is [Helm Hub](https://hub.helm.sh/), an aggregator for distributed chart repos. This central registry that has risen from the need for us to have a single place for us to search for charts. While these charts are listed here, the actual charts are hosted in a growing variety of repos. If you find a chart of interest the page for the specific chart will reveal the chart name, list of versions ([semver.org](https://semver.org/) format) and the repo where the chart can be found.

There are over 1400 charts available and growing each day.

`helm search hub | wc -l`{{execute}}

You can search the Helm Hub for specific charts.  

`helm search hub clair`{{execute}}

You will find different organizations offering overlapping chart solutions for installing a specific technology your are looking for. Look at the various providers for Redis.

`helm search hub redis`{{execute}}

At last count there were about 15 Redis related public charts. One provider who has been prolific at providing well written charts is Bitnami. So let's narrow our search.

`helm search hub redis | grep bitnami`{{execute}}

For this scenario we are interested in the [Redis chart described here](https://hub.helm.sh/charts/bitnami/redis). Click on that hyperlink to see the chart hosting details.

## Repos

While the chart is listed in Helm Hub, the Bitnami organization has a public repo of all its charts. In each Helm Hub chart page a repo is listed for you to add for access the chart. The instructions for the Redis chart says to add the bitnami repo.

`helm repo add bitnami https://charts.bitnami.com/bitnami`{{execute}}

Your Helm now has access to the Bitnami charts.

`helm repo list`{{execute}}

Instead of searching the Hub for charts you can also search the Bitnami repo.

`helm search repo bitnami/redis`{{execute}}

The Helm command can reveal additional information about the chart.

`helm show chart bitnami/redis`{{execute}}

The readme.

`helm show readme bitnami/redis`{{execute}}

The definable context values.

`helm show values bitnami/redis`{{execute}}

## Fabric8

As another example, if you search Helm for _fabric8_, nothing will be listed.

`helm search repo fabric8`{{execute}}

This is because fabric8 maintains its own chart repository that can be added to Helm.

`helm repo add fabric8 https://fabric8.io/helm`{{execute}}

With this, the repo will appear in the repo list.

`helm repo list`{{execute}}

Now, their charts can be listed.

`helm search repo fabric8`{{execute}}

Now you know how to find and list public charts. In the next step you will install the Redis chart you discovered.
