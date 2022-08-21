The scenario clones a small example Python microservice that has already been written and placed in a public source repository.

This is a small example microservice coded in Python. It demonstrates some basic REST-based commands that maintain a list of mountain information. The REST calls setup basic CRUD instructions to create, read, update, and delete information about mountains. Why mountains? It's arbitrary and generic. This service does not connect to a database, but provides a skeleton where that certainly could be added as a teaching exercise. The microservice leverages the [FastAPI](https://fastapi.tiangolo.com/) web framework for Python.

Clone the source for the sample Python project and inspect the code.

`git clone https://github.com/javajon/mountains-service-pi`{{execute}}

Navigate into the directory.

`cd mountains-service-pi`{{execute}}

Inspect the layout of the source files.

`tree`{{execute}}

The application source code is in the `app` directory. There are three Dockerfile variations and we will explore their varying efficiencies. Lastly, there is a pipeline directory that contains the Kaniko YAML manifests for executing a CI/CD pipeline on Kubernetes to build and deliver this microservice to Kubernetes.

Spend a moment to explore the small Python code that uses FastAPI.

<img align="right" src="./assets/python.png" width="150">

Here is the main entry into the application service.

`ccat app/main.py`{{execute}}

Here is the primary code that defines a skelton of REST enpoints.

`ccat app/api/mountains.py`{{execute}}

While we could run the application right here, however it would require installing the right version of Python and running pip to resolve all its dependencies. Since we are more interested in running this on Kubernetes, it's best to advance directly to packaging and running this code in a container.
