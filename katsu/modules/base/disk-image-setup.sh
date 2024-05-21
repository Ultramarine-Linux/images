#!/bin/bash -x

# force initial-setup to reconfigure the system
touch /.unconfigured

# delete the systemd files to force a fresh unconfigured state
rm /etc/{machine-id,localtime,hostname,shadow,locale.conf}
