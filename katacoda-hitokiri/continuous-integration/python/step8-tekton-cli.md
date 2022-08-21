Because Tekton is a Kubernetes Operator, it can be completely administered using the standard Kubernetes manifests using the defined custom resources that have been associated with the Tekton controllers. You can use the kubectl tool as a way to manually manage these resources. For convenience, a command-line tool called `tkn` can optionally manage these same Tekton resources.

Install the `tkn` command-line tool by getting the tar and extracting the binary to the path.

`curl -LO https://github.com/tektoncd/cli/releases/download/v0.11.0/tkn_0.11.0_Linux_x86_64.tar.gz`{{execute}}

`tar xvzf tkn_0.11.0_Linux_x86_64.tar.gz -C /usr/local/bin/ tkn`{{execute}}

More details on its various installation forms is in the [installation documentation](https://github.com/tektoncd/cli).

Verify the CLI tool is installed and ready to control the Tekton control panel.

`tkn version`{{execute}}

Like many command-line tools, you will also want to add the CLI autocompletion. As you type lengthy commands, the tab key will make the best guess to fill in the command details.

`source <(tkn completion bash)`{{execute}}

With the `tkn` tool installed, instead of running this:

`kubectl get pipelineresources`{{execute}}

you can run this:

`tkn resources list`{{execute}}

To see the resources you can manage, invoke the command without any options.

`tkn`{{execute}}

Each resource can be acted upon using the typical verbs `create`, `delete`, `describe`, `list`.

`tkn resources --help`{{execute}}

Once you submit some declarations for the pipeline, we will revisit this `tkn` tool.

There is also a [VSCode plugin for Tekton](https://github.com/redhat-developer/vscode-tekton) that matches the functionality of the CLI tool and provides editor support for the Tekton resource YAML files.
