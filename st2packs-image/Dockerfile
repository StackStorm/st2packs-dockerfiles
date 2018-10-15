FROM stackstorm/st2packs:builder AS builder

# Install custom packs
RUN /opt/stackstorm/st2/bin/st2-pack-install ${PACKS}

###########################
# Add packs and virtualenvs from builder.
FROM stackstorm/st2packs:runtime
