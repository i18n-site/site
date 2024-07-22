#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex
source env.sh

if ! command -v sponge &>/dev/null; then
  case $(uname -s) in
  Linux*)
    apt-get install -y moreutils
    ;;
  Darwin*)
    brew install moreutils
    ;;
  esac
fi

export NODE_ENV=production

de() {
  mise exec -- $DIR/$1.coffee
}

./plugin.sh
de svg.var

cd ..
bun x plugin
de i18n.dist

CDN="//_I/" bun x vite build

de dist
#_I18N+"@latest/"
