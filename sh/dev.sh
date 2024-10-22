#!/usr/bin/env bash
DIR=$(dirname $(realpath "$0"))

cd $DIR/..

set -ex
kill -9 $(lsof -i:$VITE_PORT -t) 2>/dev/null || true

if [ -z "$VITE_PORT" ]; then
  VITE_PORT=7778
fi

VITE_HOST=127.0.0.1
CDN=/

if command -v open &>/dev/null; then
  bash -c "sleep 1 && open https://$VITE_HOST:$VITE_PORT" &
fi

bun x concurrently --kill-others \
  -r "CDN=$CDN VITE_HOST=$VITE_HOST VITE_PORT=$VITE_PORT bun x vite"
