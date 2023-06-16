#!/bin/bash

export dest_path=""
export dest_folder_without_patch=""
export dest_version=""
export build_path=""
export workdir="workdir"
export outputs="outputs"

download_symengine_release () {
    rm -rf "$2/"
    mkdir "$2/"
    local crnt_dir=$(pwd)
    cd "$2" || return 3
    echo "Downloading release $1 of SymEngine from Github..."
    local fname="symengine-${1}.tar.gz"
    local fname_without_ext="symengine-${1}"
    local patched_dir="${fname_without_ext}-patched"
    local link="https://github.com/symengine/symengine/releases/download/v${1}/${fname}"
    echo "The link is: ${link}"
    
    if wget "$link" &> /dev/null; then
        if tar -xf "${fname}" &> /dev/null; then
            mv "${fname_without_ext}" "${patched_dir}"
            echo 'Done.'
            dest_path="$2/${patched_dir}/"
            dest_version="$1"
            dest_folder_without_patch="$2/$fname_without_ext"
            cd "$crnt_dir" || return 4
            return 0
        else
            echo "Failed to decompress the file: ${fname}."
            cd "$crnt_dir" || return 4
            return 2
        fi
    else
        echo "Failed to download the file from Github: ${fname}."
        cd "$crnt_dir" || return 4
        return 1
    fi
}

patch_all () {
    echo 'Pathing all the files...'
    local crnt_dir=$(pwd)
    cd "$1" || return 1
    echo "$(pwd)"
    patch -i "${crnt_dir}/symengine-${dest_version}.diff" -p2
    cd "$crnt_dir" || return 1
    echo 'Pathing has been done.'
}

build_all () {
    local crnt_dir=$(pwd)
    cd "$1" || return 1
    rm -rf build
    mkdir build
    cd build || return 2
    cmake \
    -DWITH_SYMENGINE_THREAD_SAFE=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_BENCHMARKS=OFF \
    -DWITH_MPFR=ON \
    -DWITH_SYMENGINE_RCP=ON .. && make "-j$(nproc --all)"
    build_path=$(pwd)
    echo -e "\n\nThe built binaries are at the path below:\n$build_path"
}
