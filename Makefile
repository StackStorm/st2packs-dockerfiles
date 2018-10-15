# ST2_VERSION should be the set to the version of st2 in the k8s cluster
ST2_VERSION?=3.0dev

.PHONY: image
image:
	@docker build --build-arg PACKS="st2" \
		--build-arg ST2_VERSION=${ST2_VERSION} \
		-t st2packs:latest \
		st2packs-image

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

all: builder runtime image
