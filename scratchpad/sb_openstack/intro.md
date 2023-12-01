## Workshop Prerequisites

- Nothing! Just you and a bit of time

## Goals

See how far we can get with SmartBears Open Source tools, from an OpenAPI definition.

## Overview

An API description, adhering to the OpenAPI specification, can provide inputs for multiple aspects of the SDLC.

SmartBear provides a range of Open Source tools that leverage the OpenAPI specification in order to provide different capabilities. 

In this tutorial, we will take a look at some of them.

We will need our tutorial repository from GitHub.

You can clone it to your machine by using the following command, or you can use the integrated terminal and editor in your browser to run the steps.

👉🏼 `git clone https://github.com/SmartBear-DevRel/openstack.git`{{exec}}

You can check the contents of the repo with the following command

👉🏼 `ls -1 openstack`{{exec}}

Let's change directory to the `openstack` repository

👉🏼 `cd ~/openstack`{{exec}}

There is a `Makefile` in the `openstack` repository that contains various commands in order to pull down and run the various tools in our demo. You can see all the available commands

👉🏼 `make help`{{exec}}

### Check

Before moving to the next step, check the following:

1. There is a directory called `openstack` in your workspace.
2. There is a `Makefile` in the `openstack` folder
