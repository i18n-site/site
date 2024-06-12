#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

git pull

rm -rf dist
cd sh
direnv exec . ./dist.sh
cd $DIR

# if [ -f "conf/upload.sh" ]; then
#   cd conf
#   direnv exec . ./upload.sh
# fi
# echo $CDN

#rm -rf "../dist/.18"

# bun x xxai-dist
# git add -u
# git commit -m'dist' || true
# git push
#
# if [ -v GIT_PAGE ]; then
#   mkdir -p dist.git
#   cd dist.git
#   gitdir=$(basename $GIT_PAGE)
#   gitdir=${gitdir%.git}
#   gitdir="${gitdir#*:}"
#   rm -rf $gitdir
#   cp -R ../dist $gitdir
#   cd $gitdir
#   git init
#   git add .
#   git commit -m'dist'
#   git branch -M main
#   git remote add origin $GIT_PAGE
#   git push -f -u origin main
# fi
