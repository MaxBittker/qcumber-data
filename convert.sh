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
        ls $1/* -1 | sed 's/\.json//g' | xargs -I{} -P 4 \
            bash -c "../node_modules/.bin/json2yaml {}.json > ../data/{}.yaml"
    )
    echo "Done $1"
}

convert sections
convert courses
convert subjects
convert textbooks
