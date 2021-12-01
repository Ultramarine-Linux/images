FROM fedora:35

RUN dnf install -y lorax-lmc-novirt vim-minimal pykickstart livecd-tools make && dnf clean all
RUN dnf install -y https://repos.ultramarine-linux.org/results/ultramarine-35-x86_64/ultramarine-repos-35-0.41/ultramarine-repos-common-35-0.41.x86_64.rpm
RUN dnf install -y onceler
RUN echo '%_install_langs C:en:en_US:en_US.UTF-8:it:it_IT:it_IT.UTF-8' > /etc/rpm/macros.image-language-conf

RUN mv /usr/bin/fallocate /usr/bin/fallocate.real
ADD fallocate_btrfs_workaround.sh /usr/bin/fallocate

RUN mkdir /spin
WORKDIR /spin

ENTRYPOINT [ "make" ]
