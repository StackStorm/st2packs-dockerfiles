# Overview

In the kubernetes cluster, the `st2 pack install` command will not work. By default, only system
packs are provided. If you need additional packs, bake them into a custom docker image using the instructions below. The image will provide `/opt/stackstorm/{packs,virtualenvs}` via a sidecar container in pods which need access to the packs. These volumes are mounted read-only.

# Building the st2packs image

To build your own custom `st2packs` image, run:

```
docker build --build-arg PACKS="<pack names>" -t st2packs:latest st2packs
```

where `<pack names>` is a space separated list of packs you want to install
in the st2packs image.

# Helper images

The following images are used to simplify the `st2packs` Dockerfile.

## st2packs-builder

This image includes all the dependencies required to run `st2-pack-install`. It adds some
`ONBUILD` instructions that run when building the `st2packs` image. This allows us to simplify
the st2packs `Dockerfile`.

## st2packs-runtime

Used to minimize the size of the image containing the packs.
Adds some ONBUILD instructions that run when building the `st2packs` image.
These instructions copy the `/opt/stackstorm/packs` and `/opt/stackstorm/virtualenvs`
directories into an `alpine:3.8` image.

NOTE: We decided to use `alpine` instead of `scratch` because `alpine` is small (~4MB)
and includes the `cp` command and required dependencies.
