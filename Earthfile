
VERSION 0.6

FROM fedora:37

RUN dnf install -y dnf-plugins-core
RUN dnf config-manager --add-repo  https://github.com/andaman-common-pkgs/subatomic-repos/raw/main/terra37.repo
RUN dnf install -y pykickstart lorax-lmc-novirt




build:
    
    ARG --required variant
    COPY . .
    RUN --privileged ./build.sh $variant
    SAVE ARTIFACT ./build

    # artifacts

