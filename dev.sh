#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

if [ ! -d "node_modules" ]; then
  ni
fi

./sh/plugin.sh

run() {
  direnv exec . $@
}

run bun x plugin
rm -rf node_modules/.vite vite.config.js.timestamp-*.mjs
run ./sh/svg.var.coffee
cd src

cd $DIR

# link() {
#   sleep 1
#   wasm=__bg.wasm
#   deps=node_modules/.vite/deps/$wasm
#   if [ ! -s "$deps" ]; then
#     mkdir -p $(dirname $deps)
#     ln -s ../../@3-/vite/$wasm $deps
#   fi
# }
# link &
# cd $DIR
exec ./sh/dev.sh
