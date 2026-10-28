ARG RELEASE

FROM ghcr.io/ultramarine-linux/ultramarine:${RELEASE}

LABEL com.github.containers.toolbox="true"

RUN dnf install -y passwd shadow-utils util-linux vte-profile host-spawn && dnf clean all
