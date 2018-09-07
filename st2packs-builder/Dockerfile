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
