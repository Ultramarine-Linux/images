#!/bin/bash
set -x

sed -i 's/allowed_installtypes = \["wholedisk", "custom"\]/allowed_installtypes = \["chromebookinstall"\]/' /etc/readymade.toml
