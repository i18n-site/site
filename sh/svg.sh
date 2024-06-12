#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

cd $DIR/..

zip() {
  bun x svgo --config $DIR/svgo.config.cjs -r -f $1 -o $1
}

zip file
zip public
cd $DIR
direnv exec . ./svg.var.coffee
