Just to emphasize.

`echo "The number of chart on Helm Hub is: $(helm search hub | wc -l)."`{{execute}}

The chart count is consistently increasing with the maturing Kubernetes ecosystem. There are numerous common charts that, as a Kubernetes developer, you may want to leverage.

- `helm search hub postgres`{{execute}}
- `helm search hub sonarqube`{{execute}}
- `helm search hub rabbitmq`{{execute}}
- `helm search hub kafka`{{execute}}
- `helm search hub prometheus-operator`{{execute}}
- `helm search hub tensorflow`{{execute}}
- `helm search hub tekton`{{execute}}

> The [stable and incubator locations for charts is deprecating](https://github.com/helm/charts#deprecation-timeline), so avoid those. These Katacoda scenarios are updated to use the new charts as they become available. In the meantime, you will occasionally see a warning message that the chart is deprecated.

The source code for most charts is typically backed with a GitHub repo, a readme, and a team of people that are subject matter experts in forming these opinionated charts. As an example, take a look at the [Minio chart source](https://github.com/minio/charts) and scan the README to learn how this chart can be installed and configured. There will always be a section for installation and a section for the configuration that will tell you how to effectively install the chart for your specific target.

What about creating your own chart? In the next step, let's create a chart.
