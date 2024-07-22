#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

rm -rf node_modules bun.lockb

cache=$HOME/.bun/install/cache
if [ -d "$cache" ]; then
  cd ~/.bun/install/cache
  find . -name "*.npm" | xargs rm
  cd $DIR
fi

ncu -u --dep peer,prod,dev
bun i
