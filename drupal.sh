#!/bin/bash

# Simple end-to-end test of ddev-live
# Create new site
# Wait for it to be ready
# curl it to make sure it got ready
# Push db and files to it
# Wait for those to complete
# curl site and verify content
# Do some exec commands (drush status? drush uli?)
# delete the site

# Requires jq

set -o errexit
set -o pipefail
set -o nounset

# We'll want to add args later, but for now static configuration
GITHUB_REPO="ddev-demo/my-drupal-${1}-site"
SITE_BASENAME="d${1}"
SITENAME="${SITE_BASENAME}-$(date +%Y%m%d%H%M)"
DEFAULT_ORG=e2e-tests
TIMEFORMAT='Cmd time: %0lR'

function cleanup {
    printf "Completion status is %s\n" "$?"
}
trap cleanup EXIT

function elapsed {
    ELAPSED_TIME=$(expr ${SECONDS} - "${START_TIME}")
    printf "Elapsed time=$( expr "$ELAPSED_TIME" / 60 ):$( expr "$ELAPSED_TIME" % 60 )\n"
}
# Consider downloading and installing latest ddev-live-client and using it.

START_TIME=${SECONDS}

printf "Creating site %s" "${SITENAME}"
ddev-live auth --token="${DDEV_LIVE_TOKEN}" --default-org=${DEFAULT_ORG}

set -x
time ddev-live create site drupal "${SITENAME}" --github-repo="${GITHUB_REPO}" --run-composer-install --docroot web --drupal-version="${1}" --php-version=7.3
set +x
elapsed

time ./wait_site_healthy.sh "${SITENAME}"
echo -ne '\007' >&2
elapsed
echo

# It's unknown how long you have to sleep to avoid
# https://github.com/drud/ddev-live/issues/348
set -x
time ddev-live push db "${SITENAME}" assets/"${SITE_BASENAME}".sql.gz
time ddev-live push files "${SITENAME}" assets/"${SITE_BASENAME}"  ./ >/tmp/filespush."${SITENAME}" 2>&1
#time ddev-live exec "${SITENAME}" -- drush uli -l "${url#http://preview-}"
set +x

url=$(ddev-live describe site "${SITENAME}" -o json | jq -r .previewUrl)
time ./wait_curl_healthy.sh "$url"
elapsed

printf "It all seems to have worked out OK: ${url}\n"
elapsed
# Add curls here to wait for it to come up and check some content.
