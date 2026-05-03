#!/bin/bash
set -euo pipefail
. "$(dirname "${BASH_SOURCE[0]}")/mkosi.sh"

output_dir=$(dirname "$MKOSI_CONFIG")
shafile_content=""

for file in "$output_dir"/"$MKOSI_OUTPUT".*; do
    # strip full path from sha256sum output, only keep the filename
    if [[ "$file" == *"$MKOSI_OUTPUT.sha256" ]]; then
        continue
    fi
    echo "Hashing $file"
    sum=$(sha256sum "$file" | sed 's|  .*/|  |')

    shafile_content+="$sum\n"
done
echo -e "$shafile_content" > "$output_dir/$MKOSI_OUTPUT.sha256"
