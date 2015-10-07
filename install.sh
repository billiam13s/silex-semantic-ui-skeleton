#!/bin/bash

# -e Exit any line fails
# -x Print commands
set -e

cwd=$(pwd)

echo "Porject name [ENTER]:"
read project

function check {
    fails=0

    # array of scripts require to run
    scripts=(composer npm)

    # check if each scripts exists
    for script in "${scripts[@]}" ; do
        if ! hash $script 2>/dev/null; then
            printf "require \e[33m%s\n\e[0m" "$script"
            let "fails += 1"
        fi
    done

    if [ $fails -gt 0 ] ; then
        printf "\e[31mFail to install\n\e[0m"
        exit 0
    fi
}

check

composer create-project fabpot/silex-skeleton $project

cd $project && echo {} >> package.json && npm i semantic-ui --save
