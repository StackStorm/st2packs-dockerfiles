# A minimally sized image used to build st2 pack images
FROM alpine:3.8

# Add st2-pack-install dependencies
RUN apk add --no-cache python \
  && python -m ensurepip \
  && rm -r /usr/lib/python*/ensurepip \
  && pip install --upgrade pip setuptools \
  && pip install GitPython lockfile virtualenv \
  && apk add --no-cache \
    gcc \
    git \
    libffi-dev \
    libressl-dev \
    linux-headers \
    make \
    musl-dev \
    python-dev \
    sudo

# Add st2common (orquesta must be installed separately otherwise there is an error when installing st2common)
RUN pip install -e git+https://github.com/StackStorm/orquesta.git@master#egg=orquesta
RUN pip install -e git+https://github.com/StackStorm/st2#egg=st2common\&subdirectory=st2common

# Before running st2-pack-install, ensure a basic st2.conf file exists and ARG PACKS is available
ONBUILD RUN mkdir -p /etc/st2
ONBUILD COPY files/st2.conf /etc/st2/st2.conf
ONBUILD ARG PACKS
ONBUILD RUN : "${PACKS:?Please add '--build-arg PACKS=\"<space separated list of pack names>\"'.}"
