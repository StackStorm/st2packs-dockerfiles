FROM stackstorm/st2packs:builder AS builder

ARG SSH_PRIVATE_KEY
COPY configure_ssh_key.sh /tmp/configure_ssh_key.sh
RUN bash /tmp/configure_ssh_key.sh

# Install custom packs
RUN /opt/stackstorm/st2/bin/st2-pack-install ${PACKS}

# Remove private key
RUN rm -f /root/.ssh/id_rsa

###########################
# Minimize the image size. Start with alpine:3.8,
# and add only packs and virtualenvs from builder.
FROM stackstorm/st2packs:runtime
