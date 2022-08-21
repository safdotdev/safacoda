Pipeline Resources are entities that define the locations for inputs ingested and outputs produced by the steps in Tasks.

<img align="right" src="./assets/git.png" width="150">

The pipeline is not just one file, rather it's a collection of modular and decoupled resource types that definitions the elements of your pipeline. When you define the top-level PipelineRun it references sub definitions to complete your request.

```text
Pipeline Run
    Pipeline
        Tasks
            Steps
                Resources
```

We have defined the Git repo where the application source code resides.

`ccat pipeline/git-resource.yaml`{{execute}}

Apply this PipelineResource declaration.

`kubectl apply -f pipeline/git-resource.yaml`{{execute}}

Verify the Resource has been declared.

`tkn resources list`{{execute}}
