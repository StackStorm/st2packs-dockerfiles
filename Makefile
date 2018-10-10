ST2_VERSION?=3.0dev

.PHONY: build
build:
	@docker build --build-arg ST2_VERSION=${ST2_VERSION} -t stackstorm/st2packs:builder-${ST2_VERSION} st2packs-builder
	@docker build --build-arg ST2_VERSION=${ST2_VERSION} -t stackstorm/st2packs:runtime-${ST2_VERSION} st2packs-runtime
	@docker build --build-arg PACKS="st2" -t stackstorm/st2packs:image st2packs-image
