# st2packs-runtime

Uses ONBUILD instructions that run when building the `st2packs` image.
These instructions copy the `/opt/stackstorm/packs` and `/opt/stackstorm/virtualenvs`
directories from the builder image into a `stackstorm/st2` image.
