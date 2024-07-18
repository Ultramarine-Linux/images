ARG RELEASE

FROM ghcr.io/ultramarine-linux/ultramarine:${RELEASE}

RUN dnf install -y @development-tools
