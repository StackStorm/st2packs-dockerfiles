.PHONY: image
image:
	@docker build --build-arg PACKS="st2" \
		-t st2packs:latest \
		st2packs-image

.PHONY: builder
builder:
	@docker build \
		-t stackstorm/st2packs:builder \
		st2packs-builder

.PHONY: runtime
runtime:
	@docker build \
		-t stackstorm/st2packs:runtime \
		st2packs-runtime

all: builder runtime image
