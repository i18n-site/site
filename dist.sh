#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

git pull

rm -rf dist
cd sh
./init.sh
mise exec -- ./dist.sh
cd $DIR
