#!/bin/bash

source ./functions.sh

if download_symengine_release "0.10.1" "$outputs"; then
    if patch_all "$dest_path"; then
        build_all "$dest_path"
    fi
fi
