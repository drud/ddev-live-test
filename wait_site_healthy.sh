#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

sitename=${1-nosite}

echo "waiting for site ${sitename}: $(date)" >&2

for i in {1000..0}; do
#  status=$(ddev-live describe site ${sitename} | grep -v "Using org: " | jq -r .status.conditions[1].status)
  previewUrl=$(ddev-live describe site ${sitename}  -o json | jq -r .previewUrl )

  if [ "${previewUrl}" != "" ]; then
    printf "\nSite ${sitename} seems to have become ready at $(date) \007\n" >&2
    exit 0
  fi
  printf "." >&2
  sleep 10
done

printf "\nsite ${sitename} never became ready, giving up at $(date) \007\n" >&2
exit 2
