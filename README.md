[![Go to Docker Hub](https://img.shields.io/docker/build/stackstorm/st2packs.svg)](https://hub.docker.com/r/stackstorm/st2packs/)

# Overview

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
docker build --build-arg PACKS="<pack names>" -t ${DOCKER_REGISTRY}/st2packs:latest st2packs-image
```

where `<pack names>` is a space separated list of packs you want to install in the st2packs image
and `<docker_registry>` is the registry URL. If you have enabled the k8s Docker Registry using
`docker-registry.enabled = true` in the Helm chart configuration `values.yaml` at
https://github.com/stackstorm/stackstorm-ha,
then set `<docker_registry>` to `localhost:5000`.

# Building the st2packs image with private packs

In order to pull packs from private repository, you have to use a [deploy key](https://developer.github.com/v3/guides/managing-deploy-keys/#deploy-keys) for that specific repository and use it to pull it via SSH protocol.

After you created the key, you can build the image as follows:

```
docker build --build-arg PACKS="<pack names>" --build-arg SSH_PRIVATE_KEY=${SSH_PRIVATE_KEY} -t ${DOCKER_REGISTRY}/st2packs:latest st2packs-image
```

where `<pack names>` can include links to private repositories (`git@github.com:<user>/<repository>.git`)
and `SSH_PRIVATE_KEY` contains your private key.

# Helper images

The `st2packs-builder` and `st2packs-runtime` directories each contain a Dockerfile for images that
are used to simplify the `st2packs` Dockerfile.
