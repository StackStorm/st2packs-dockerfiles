[![Go to Docker Hub](https://img.shields.io/docker/build/stackstorm/st2packs.svg)](https://hub.docker.com/r/stackstorm/st2packs/)

# ELI5

It is not possible to install a custom pack on the Kubernetes cluster the same way as you know it. Instead, you need to package your custom implementation in a special delivery medium known as a container and have it deployed to your cluster. We tweaked this project to make sure you have access to tools that help you accomplish that. Easily pick a method that better suits your needs.

# The Runtime method
our RuntimeDocker is The quickest way to move everything from a standalone serve, over to the kuberenetes cluster.  This method simply  copies everything locatedd in `/opt/stackstorm/packs` and `/opt/stackstorm/virtualenvs` in bulk and packs everything in a container ready for deployement. 

> Make sure you have **git** and **Docker Engine** installed.

```bash
# set the build context and git clone repository
cd /opt && sudo git clone https://github.com/StackStorm/st2packs-dockerfiles.git  && cd st2packs-dockerfiles/st2packs-builder
```
```bash
# build a docker image 
sudo docker --no-cache build -t MyContainer/st2Packs .
```
If all goes well, you should see something like this 

```bash
Step 1/4 : FROM alpine:3.8
 ---> dac705114996
Step 2/4 : ONBUILD VOLUME ["/opt/stackstorm/packs", "/opt/stackstorm/virtualenvs"]
 ---> Using cache
 ---> d6e67dd745b3
Step 3/4 : ONBUILD COPY --from=builder /opt/stackstorm/packs /opt/stackstorm/packs
 ---> Using cache
 ---> ec51ace2ec7e
Step 4/4 : ONBUILD COPY --from=builder /opt/stackstorm/virtualenvs /opt/stackstorm/virtualenvs
 ---> Using cache
 ---> 2ad13f8a4477
Successfully built 2ad13f8a4477
Successfully tagged MyContainer/st2Packs:latest
```

-  using alpine since it's lighter and faster. 
- `--no-cache` to catch  all updates.
-  `packs` & `virtualenvs`  included



# Building the st2packs image

To build your own custom `st2packs` image, run:

```
git clone git@github.com:stackstorm/st2packs-dockerfiles
cd st2packs-dockerfiles
docker build --build-arg PACKS="<pack names>" -t ${DOCKER_REGISTRY}/st2packs:latest st2packs
```

where `<pack names>` is a space separated list of packs you want to install in the st2packs image
and `<docker_registry>` is the registry URL. The pack may be specified as a github url, or as a
local file (e.g. file://<path to file>). In the latter case, then you need to ensure these are
COPY'd into the docker build environment. As an example,

```
ARG PACKS="file:///tmp/stackstorm-st2"

FROM stackstorm/st2packs:builder AS builder
# considering you have your "local" pack under the `stackstorm-st2` dir relative to Dockerfile
# Here we copy local "stackstorm-st2" dir into Docker's "/tmp/stackstorm-st2"
COPY stackstorm-st2 /tmp/stackstorm-st2/
# Check it
RUN ls -la /tmp/stackstorm-st2

RUN /opt/stackstorm/st2/bin/st2-pack-install ${PACKS}
FROM stackstorm/st2packs:runtime
```

If you have enabled the k8s Docker Registry using `docker-registry.enabled = true`
in the Helm chart configuration `values.yaml` at https://github.com/stackstorm/stackstorm-ha,
then set `<docker_registry>` to `localhost:5000`.

# Helper images

The `st2packs-builder` and `st2packs-runtime` directories each contain a Dockerfile for images that
are used to simplify the `st2packs` Dockerfile.

By default, only system packs are available to StackStorm services when installed using the
stackstorm-ha [helm chart](https://helm.stackstorm.com). If you need additional packs,
bake them into a custom docker image using the instructions below.

The `st2packs` image will mount `/opt/stackstorm/{packs,virtualenvs}` via a sidecar container in
pods which need access to the packs. These volumes are mounted read-only. In the kubernetes cluster,
the `st2 pack install` command will not work.

# Building the st2packs image

To build your own custom `st2packs` image, run:

```
git clone git@github.com:stackstorm/st2packs-dockerfiles
cd st2packs-dockerfiles
docker build --build-arg PACKS="<pack names>" -t ${DOCKER_REGISTRY}/st2packs:latest st2packs
```

where `<pack names>` is a space separated list of packs you want to install in the st2packs image
and `<docker_registry>` is the registry URL. The pack may be specified as a github url, or as a
local file (e.g. file://<path to file>). In the latter case, then you need to ensure these are
COPY'd into the docker build environment. As an example,

```
ARG PACKS="file:///tmp/stackstorm-st2"

FROM stackstorm/st2packs:builder AS builder
# considering you have your "local" pack under the `stackstorm-st2` dir relative to Dockerfile
# Here we copy local "stackstorm-st2" dir into Docker's "/tmp/stackstorm-st2"
COPY stackstorm-st2 /tmp/stackstorm-st2/
# Check it
RUN ls -la /tmp/stackstorm-st2

RUN /opt/stackstorm/st2/bin/st2-pack-install ${PACKS}
FROM stackstorm/st2packs:runtime
```

If you have enabled the k8s Docker Registry using `docker-registry.enabled = true`
in the Helm chart configuration `values.yaml` at https://github.com/stackstorm/stackstorm-ha,
then set `<docker_registry>` to `localhost:5000`.

# Helper images

The `st2packs-builder` and `st2packs-runtime` directories each contain a Dockerfile for images that
are used to simplify the `st2packs` Dockerfile.
