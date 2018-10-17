# st2packs-runtime

Used to minimize the size of the image containing the packs.
Uses ONBUILD instructions that run when building the `st2packs` image.
These instructions copy the `/opt/stackstorm/packs` and `/opt/stackstorm/virtualenvs`
directories from the builder image into a `alpine:3.8` image.

NOTE: We decided to use `alpine` instead of `scratch` because `alpine` is small (~4MB)
and includes the `cp` command and required dependencies.