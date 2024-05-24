#!/bin/bash

set -euxo pipefail

echo "Setting up SELinux..."

setfiles -e /proc -e /sys /etc/selinux/targeted/contexts/files/file_contexts /