#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

if [ ! -d ../node_modules ]; then
  rm -rf ../bun.lockb
  if [ ! -d node_modules ]; then
    bun i
  fi
  ./install.js
fi
