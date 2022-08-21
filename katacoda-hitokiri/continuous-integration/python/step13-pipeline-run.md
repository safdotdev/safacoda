PipelineRuns are entities that declare the trigger to run a pipeline. The triggered pipeline is given specific contexts for inputs, outputs, and execution parameters.

We have defined the PipelineRun.

`ccat pipeline/pipeline-run.yaml`{{execute}}

Notice the provided parameters and ServiceAccount which will be offered contexts to the tasks. Apply this PipelineResource declaration.

`kubectl apply -f pipeline/pipeline-run.yaml`{{execute}}

Verify the Resource has been declared.

`tkn pipelineruns list`{{execute}}

The pipeline is now running!

`tkn pipelineruns describe application-pipeline-run`{{execute}}

Check the [Registry](
https://[[HOST_SUBDOMAIN]]-31000-[[KATACODA_HOST]].environments.katacoda.com/) from the tab above and in a moment a new _app_ container will appear in the list.

Check the [Tekton dashboard](
https://[[HOST_SUBDOMAIN]]-32500-[[KATACODA_HOST]].environments.katacoda.com/) from the tab above and you will see pipeline running that builds the container images and deploys container. The pipeline will only appear in the dashboard when it's running and will be removed from the interface once it completes.

Next, verify the newly deployed application.
