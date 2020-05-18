#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

sitename=${1-nosite}

echo "waiting for site ${sitename}: $(date)" >&2

for i in {10..0}; do
    if ! ddev-live describe site ${sitename} >/dev/null 2>/dev/null ; then
        echo -n "#"
        sleep 1
    fi
done
echo

for i in {1000..0}; do
  descOut=$(ddev-live describe site ${sitename} -o json)
  previewUrl=$(echo "${descOut}" | ddev-live describe site ${sitename}  -o json | jq -r .previewUrl )
  siteHealthy=$(echo "${descOut}" | ddev-live describe site ${sitename}  -o json | jq -r .site.healthy )
  filestoreHealthy=$(echo "${descOut}" | ddev-live describe site ${sitename}  -o json | jq -r .fileStore.healthy )
  databaseHealthy=$(echo "${descOut}" | ddev-live describe site ${sitename}  -o json | jq -r .database.healthy )

  if [ "${previewUrl}" != "" ] && [ ${siteHealthy} = "true" ] && [ ${filestoreHealthy} = "true" ] && [ ${databaseHealthy} = "true" ]; then
    printf "\nSite ${sitename} seems to have become ready at $(date) \007\n" >&2
    exit 0
  fi
  printf "." >&2
  sleep 10
done

printf "\nsite ${sitename} never became ready, giving up at $(date) \007\n" >&2
exit 2
