#!/bin/bash -x

# enable the surface kernel watchdog to force grub to highlight it regardless of which entry it is
sudo systemctl enable linux-surface-default-watchdog.path
