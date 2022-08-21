Helm is a cluster administration tool that manages _charts_ on Kubernetes.

Helm relies on a packaging format called _charts_. Charts define a composition of related Kubernetes resources and values that make up a deployment solution. Charts are source code that can be packaged, named, versioned, and maintained in version control. The chart is a collection of Kubernetes manifests in the form of YAML files along with a templating language to allow contextual values to be injected into the YAMLs. Charts complement your infrastructure-as-code ([IaC](https://en.wikipedia.org/wiki/Infrastructure_as_code)) processes.

Helm also helps you manage the complexities of dependency management. Charts can include dependencies on other charts. A chart is a deployable unit that can be inspected, listed, updated, and removed. The Helm CLI tool deploys charts to Kubernetes.

Interaction with Helm is through its command-line tool (CLI). This Katacoda instance already has a recent version of Helm version 3 installed and ready for use.

`helm version --short`{{execute}}

This scenario covers version 3.x of Helm. If you are using version 2.x, it's highly advisable to move to the recent version. Helm is evolving and there is a newer version available from its list of [releases](https://github.com/kubernetes/helm/releases). With its shell script installer, Helm can be installed or upgraded from a single line.

`curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash`{{execute}}

Now you have a slightly newer version of Helm.

`helm version --short`{{execute}}

Based on your preferences, your local operating system package manager (apt-get, choco, brew, etc) can also install Helm.

The current local state of Helm is kept in your environment in the _home_ location.

`helm env`{{execute}}

The Helm command line tool defaults to discovering the current Kubernetes host by reading the same configuration that kubectl uses in ~/.kube/config. There is a way to switch the current cluster context, but that's beyond the scope of this scenario.

Now that Helm is working, in the next step you will install a common public chart.
