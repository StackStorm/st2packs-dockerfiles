# Overview

Two helper images are used to build the `st2packs` image. They are described below.

# st2packs-builder

Includes all the dependencies required to run `st2-pack-install`.

# st2packs-runtime

Used to minimize the size of the image containing the packs.
Copies the `/opt/stackstorm/packs` and `/opt/stackstorm/virtualenvs` directories into an `alpine:3.8` image.

We decided to use `alpine` instead of `scratch` because `alpine` is small (~4MB) and includes the `cp` command and required dependencies.
