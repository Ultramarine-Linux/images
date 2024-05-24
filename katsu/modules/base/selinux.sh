#!/bin/bash -x

set -euxo pipefail

echo "Setting up SELinux..."

setfiles -F -r "${CHROOT}" "${CHROOT}"/etc/selinux/targeted/contexts/files/file_contexts "${CHROOT}"