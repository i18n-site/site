#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR/..
set -ex
rm -rf ./node_modules/~ && ln -s ../src node_modules/~ && bun x plugin
$DIR/pkgMerge.js
