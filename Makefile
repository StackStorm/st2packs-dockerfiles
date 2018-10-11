# ST2_VERSION should be the set to the version of st2 in the k8s cluster
ST2_VERSION?=3.0dev

all: builder runtime image

.PHONY: builder
builder:
	@docker build --build-arg ST2_VERSION=${ST2_VERSION} \
		-t stackstorm/st2packs:builder-${ST2_VERSION} \
		st2packs-builder

.PHONY: runtime
runtime:
	@docker build --build-arg ST2_VERSION=${ST2_VERSION} \
		-t stackstorm/st2packs:runtime-${ST2_VERSION} \
		st2packs-runtime

.PHONY: image
image:
	@docker build --build-arg PACKS="st2" \
		-t stackstorm/st2packs:image \
		st2packs-image
