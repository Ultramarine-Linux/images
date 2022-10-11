#!/usr/bin/bash -x

### Ultramarine Linux Image build script
# This script is used to build image for Ultramarine Linux.
# It is a part of Ultramarine Linux project.

# See LICENSE file for license information.



VERBOSE=0
# get releasever from /etc/os-release
arch=$(uname -m)
PROJECT="Ultramarine Linux"
PROJECT_SHORT="ultramarine"

ISO_NAME="${PROJECT_SHORT}-${arch}-$(date +%Y%m%d).iso"


: "${releasever:=$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"')}"


OUTPUT_DIR="build"

usage() {
    # heredoc of the actual help
    echo "\
    Usage: $0 [options] [command]
    "
}

debug() {
    if [ $VERBOSE -eq 1 ]; then
        echo "$@"
    fi
}

help() {
    echo "\
    $0 - Ultramarine Linux Image builder script
    This bash script is used to build Ultramarine Linux images.
    "
}


invalid_option() {
    echo "Invalid option: $1"
    echo "Try '$0 --help' for more information."
    exit 1
}

error() {
    echo "Error: $1"
}

EXTRA_ARGS=""

parse_variant_type() {
    # use a case statement to parse the variant type
    case $1 in

    iso)
        echo "iso"
        # add --iso-only to extra args
        EXTRA_ARGS+=" --iso-only"
        ;;
    docker)
        echo "tar"
        ;;
    podman)
        echo "tar"
        ;;
    *)
        echo "Invalid variant type: $1"
        echo "Try '$0 --help' for more information."
        exit 1
        ;;

    esac

}

lmc_builder() {
    # check if root

    # check if path in kickstart_path exists
    if [ ! -f "$kickstart_path" ]; then
        error "Kickstart file not found."
        exit 1
    fi

    if [ -d "$OUTPUT_DIR" ]; then
        # sudo rm -rf "$OUTPUT_DIR"
        true
    fi
    parse_variant_type "$variant_type"
    mkdir -p "$OUTPUT_DIR/logs"

    echo $EXTRA_ARGS

    ksflatten -c $kickstart_path -o $OUTPUT_DIR/${variant_name}-flattened.ks


    sudo livemedia-creator --make-${variant_type} \
        --no-virt \
        --resultdir ${OUTPUT_DIR}/image \
        --ks $OUTPUT_DIR/${variant_name}-flattened.ks \
        --logfile ${OUTPUT_DIR}/logs/livemedia-creator.log \
        --compression zstd \
        --project "$PROJECT" \
        --releasever $releasever \
        --isfinal \
        --release $releasever \
        --iso-name $ISO_NAME \
        --variant $variant_name $EXTRA_ARGS || exit 1


}



# build function
build() {
    true
    # check if config file exists
    if [ ! -f "config/$VARIANT" ]; then
        echo "Config file for $VARIANT does not exist."
        exit 1
    fi

    . "config/$VARIANT"
    build_type=$(parse_variant_type "$variant_type")

    debug "Got build type as: $build_type"

    lmc_builder $EXTRA_ARGS

}


# arg parser

while [[ $# -gt 0 ]];

do
    case $1 in
    -h | --help)
        help
        exit 0
        ;;
    -m | --mock)
        MOCK=1
        shift
        ;;
    -v | --verbose)
        VERBOSE=1
        shift
        ;;

    # -v | --variant)
    #     VARIANT=$2
    #     echo "variant: $VARIANT"
    #     shift 2
    #     ;;

    # positional args
    *)
        # check if its an option
        if [[ $1 == -* ]] || [[ $1 == --* ]]; then
            invalid_option "$1"
        fi
        # positional args
        VARIANT=$1
        build
        exit 0

        ;;
    esac
done



# usage
build