#!/bin/bash
# this script requires "json2yaml" to be installed from npm

set -euo pipefail
IFS=$'\n\t'

[ -e node_modules/.bin/json2yaml ] || (echo json2yaml not installed! && exit 1)

convert(){
    mkdir -p data/$1
    # wrap in brackets so don't have to worry about cd back out
    (
        cd json
        for x in $(ls $1/* -1); do
            ../node_modules/.bin/json2yaml $x > ../data/${x%.json}.yaml &
        done
        wait
    )
    echo "Done $1"
}

convert sections
convert courses
convert subjects
convert textbooks
