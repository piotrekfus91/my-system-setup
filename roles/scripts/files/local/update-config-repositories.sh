#!/bin/bash -x

scrip_dir=$(dirname "$0")

declare -a repos=( "https://github.com/powerline/fonts" "https://github.com/junegunn/fzf" "https://github.com/visit1985/mdp.git")

verify_actual() {
    repo=$1
    repoDir=$(echo $repo | awk -F/ '{print $NF}')
    if [ -d repos/$repoDir ] ; then
        cd repos/$repoDir
        git fetch
        behind=$(git rev-list --left-right --count master...origin/master | awk '{print $2}')
        if [ $behind -ne 0 ] ; then
            echo "Repository $repo is not actual" >> /tmp/non-actual-repos
        fi
        cd -
    else
        cd repos
        git clone $repo
        cd -
    fi
}

cd $scrip_dir

mkdir -p repos

rm -f /tmp/non-actual-repos

for repo in "${repos[@]}" ; do
    verify_actual $repo
done
