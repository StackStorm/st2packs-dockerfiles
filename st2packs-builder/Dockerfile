ARG ST2_VERSION
FROM stackstorm/st2:${ST2_VERSION}

ONBUILD ARG PACKS
ONBUILD RUN : "${PACKS:?Please add '--build-arg PACKS=\"<space separated list of pack names>\"'.}"
