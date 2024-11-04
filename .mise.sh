set -e
DIR=$(dirname "${BASH_SOURCE[0]}")
if echo ":$PATH:" | grep -q ":$DIR/.mise/bin:"; then
  exit 0
fi

cd $DIR

if [ ! -d "conf" ]; then
  git clone --depth=1 $(git config --get remote.origin.url | sed 's/\.git$//').conf.git conf
fi

pj=package.json
if [ ! -f "$pj" ]; then
  bun i @3-/read @3-/write @3-/yml lodash-es @3-/zx
  rm package.json
  ./sh/install.js
fi
