#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Need the release tag to work on."
    echo -e "For example: \n\t0.10.1"
    exit
fi

source ./functions.sh

if download_symengine_release "$1" "$workdir"; then
    cp -r ${dest_path} ${dest_folder_without_patch}
    echo "Now please modify the code at $(pwd)/${dest_folder_without_patch} that you want to create a patch for."
    echo "Then run \$ sh diff.sh ${dest_path} ${dest_folder_without_patch}"
fi
