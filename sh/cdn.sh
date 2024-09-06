#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

source env.sh
./i18n.upload.coffee
git add -u && git commit -m'i18n' || true

cd ..
bun x xxai-dist
