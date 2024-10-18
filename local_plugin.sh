#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

rm -rf node_modules/.pnpm
cd node_modules/@8p
rm -rf $1
ln -s ../../../plugin/$1/lib $1
