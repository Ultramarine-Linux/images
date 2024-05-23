#!/bin/bash

set -euxo pipefail

echo "Setting up SELinux..."

BIN_POLICY=$(find /etc/selinux/targeted/policy/policy.* -maxdepth 1 | sort -Vr | head -1)

setfiles -mF -c "${BIN_POLICY}" /etc/selinux/targeted/contexts/files/file_contexts /
