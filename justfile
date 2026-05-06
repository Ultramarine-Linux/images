profile := "base"
secondary_profile := ""

# join with `,`

profile_string := profile + if secondary_profile != "" { "," + secondary_profile } else { "" }
export PROFILES := profile_string
release := "44"
cache_dir := "mkosi.cache"
oci_image := "ghcr.io/ultramarine-linux" / profile + "-bootc:" + release
tar_export := cache_dir / profile + ".tar"

build: mkosi-build postprocess

full-build: prep build

prep: pack-images

postprocess:
    sudo ./scripts/postprocess.sh

prepare_dirs:
    mkdir -p {{ cache_dir }}

hash:
    ./scripts/hash.sh



# for some reason $PROFILES does not get passed through on configure script so we need this instead
mkosi-build:
    sudo mkosi --profile="{{ profile_string }}" --release="{{ release }}" -w build

clean:
    mkosi clean

pack-images: pull
    #!/bin/bash
    # create container
    container=$(podman create {{ oci_image }})
    echo "exporting image to {{ tar_export }}"
    podman export -o {{ tar_export }} $container
    echo "image exported to {{ tar_export }}"
    podman rm $container > /dev/null

pull: prepare_dirs
    @echo "pulling image {{ oci_image }}"
    podman pull {{ oci_image }}
