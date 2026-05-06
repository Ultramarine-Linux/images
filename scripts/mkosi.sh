#!/bin/bash
bashsrc=$(dirname "${BASH_SOURCE[0]}")
export MKOSI_CONFIG="$(realpath $bashsrc/../mkosi.output/manifest.json)"
export MKOSI_OUTPUT="$(jq -r '.Output' "$MKOSI_CONFIG")"
if ! [[ -f "$MKOSI_CONFIG" ]]; then
    echo "mkosi output manifest not found: $MKOSI_CONFIG"
    exit 1
fi