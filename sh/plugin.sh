#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

cd ..
plugin=plugin.js

# 不能用软连接, 不然 vite 找不到依赖

site_plugin=conf/$plugin

if [ -f "$site_plugin" ]; then
  echo -e "// DON'T EDIT THIS FILE\n// EDIT $site_plugin \n" | cat - "$site_plugin" >src/$plugin
fi
