#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Need the path to the directory without *-path"
    echo -e "For example: \n\t$ sh dev_diff.sh workdir/symengine-0.10.1"
fi

diff_fname=$(basename "$1")
diff -ur "${1}-patched" $1 > "$diff_fname.diff"
echo "The diff file has been generated: $(pwd)/$diff_fname.diff"
