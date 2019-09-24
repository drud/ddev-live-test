#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

url=${1-nosite}

echo "waiting for url ${url}: $(date)" >&2

for i in {1000..0}; do
  if curl -sSL --fail $url >/dev/null 2>&1 ; then
    echo "\nURL ${url} seems to have become 200 at $(date) \007" >&2
    exit 0
  fi
  printf "." >&2
  sleep 10
done

echo "\nurl ${url} never became ready, giving up at $(date) \007" >&2
exit 2
