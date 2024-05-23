#!/bin/bash

set -euxo pipefail

echo "Setting up SELinux..."

BIN_POLICY=$(find "${CHROOT}"/etc/selinux/targeted/policy/policy.* -maxdepth 1 | sort -Vr | head -1)

setfiles -m -F -p -r "${CHROOT}" -c "${BIN_POLICY}" /etc/selinux/targeted/contexts/files/file_contexts "${CHROOT}"
