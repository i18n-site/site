#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

if ! command -v ncu &>/dev/null; then
  bun i -g npm-check-updates
fi

ncu -u --dep peer,prod,dev
bun i
