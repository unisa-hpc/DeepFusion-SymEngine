#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Need the release tag to work on."
    echo -e "For example: \n\t0.10.1"
    exit
fi

source ./functions.sh

if download_symengine_release "$1" "$outputs"; then
    if patch_all "$dest_path"; then
        build_all "$dest_path"
    fi
fi
