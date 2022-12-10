
VERSION 0.6

FROM ghcr.io/ultramarine-linux/ultramarine:37

RUN dnf install -y pykickstart lorax-lmc-novirt


build:
    ARG variant
    RUN --privileged ./build.sh $variant
