# st2packs-builder

This image includes all the dependencies required to run `st2-pack-install`. It adds some
`ONBUILD` instructions that run when building the `st2packs` image. This allows us to simplify
the st2packs `Dockerfile`.
