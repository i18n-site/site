#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

cd $DIR/..

zip() {
  bun x svgo --config $DIR/svgo.config.cjs -r -f $1 -o $1
}

cd file/var
find . -name "*.svg" -exec sed -i 's/class="icon"//g' {} \;

cd $DIR/..

zip file
zip public
cd $DIR
mise exec -- ./svg.var.coffee
