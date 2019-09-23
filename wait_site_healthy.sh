#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

sitename=${1-nosite}

echo "waiting for site ${sitename} to become ready at $(date)" >&2

for i in {1000..0}; do
  status=$(ddev-live describe site ${sitename} | grep -v "Using org: " | jq -r .status.conditions[1].status)

  if [ ${status} = "True" ]; then
    echo "Site ${sitename} seems to have become ready at $(date) \007" >&2
    exit 0
  fi
  printf "." >&2
  sleep 10
done

echo "site ${sitename} never became ready, giving up at $(date) \007" >&2
exit 2
