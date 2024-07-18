ARG RELEASE

FROM ghcr.io/ultramarine-linux/ultramarine:${RELEASE}

RUN dnf install -y @development-tools sudo && dnf clean all

RUN useradd -l -u 33333 -G wheel -md /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod
