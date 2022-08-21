## Verify Application is Healthy

View the Pods and its exposed Service.

`kubectl get deployments,pods,services`{{execute}}

You can also check the dashboard and soon the app will appear as three pods in the default namespace.

## Access Application

View the [Python Microservice at this URL](https://[[HOST_SUBDOMAIN]]-32000-[[KATACODA_HOST]].environments.katacoda.com/).

Or, see it here through lynx.

`lynx https://[[HOST_SUBDOMAIN]]-32000-[[KATACODA_HOST]].environments.katacoda.com/ --dump`{{execute}}

Or, curl it.

`curl https://[[HOST_SUBDOMAIN]]-32000-[[KATACODA_HOST]].environments.katacoda.com/ | jq`{{execute}}

**&#x2714; You did it!** A Python microservice, in a distilled container, built with Kaniko, delivered by a Tekton pipeline, Well done!

Now go climb your next mountain, with a friend.

<img align="center" src="./assets/joshua-earle--87JyMb9ZfU-unsplash.jpg" width="400">
