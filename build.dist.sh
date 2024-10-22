#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

rm -rf dist
cd sh
./init.sh
mise exec -- ./dist.sh
cd $DIR
