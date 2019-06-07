#!/bin/bash
set -eo pipefail
shopt -s nullglob
BASE=${PWD}

if [ "${1}" = 'npm' ]; then
  echo "Installing npm libraries with yarn....."
  yarn install
fi

cd ${BASE}
exec "$@"
