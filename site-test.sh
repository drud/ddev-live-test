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
set -x

# We'll want to add args later, but for now static configuration
GITHUB_REPO=rfay/d8composer
SITE_BASENAME=d8c
SITENAME="${SITE_BASENAME}-$(date +%Y%m%d%H%M)"
DEFAULT_ORG=randy

function cleanup {
    set +x
    echo "This would do cleanup actions including 'ddev-live delete site ${SITENAME}' at this point"
    #ddev-live delete site ${SITENAME}
}
trap cleanup EXIT
function elapsed {
    ELAPSED_TIME=$(expr ${SECONDS} - ${START_TIME})
    echo "Elapsed time=$( expr $ELAPSED_TIME / 60 ):$( expr $ELAPSED_TIME % 60 )\n"
}
# Consider downloading and installing latest ddev-live-client and using it.

START_TIME=${SECONDS}

echo "Creating site ${SITENAME}"
time ddev-live create site drupal ${SITENAME} --github-repo=${GITHUB_REPO} --run-composer-install --docroot web
#ddev-live create site drupal ${SITENAME} --github-repo=${GITHUB_REPO} --drupal-version 7 --branch 7.x
elapsed

time ./wait_site_healthy.sh ${SITENAME}
echo -ne '\007' >&2
elapsed
echo

url=$(ddev-live describe site ${SITENAME} -o json | jq -r .previewUrl)
time ./wait_curl_healthy.sh $url
elapsed

time ddev-live push files ${SITENAME} assets/${SITE_BASENAME} >/tmp/filespush.${SITENAME} 2>&1

time ddev-live push db ${SITENAME} assets/${SITE_BASENAME}.sql.gz

time ddev-live exec ${SITENAME} -- drush uli

set +x
echo "It all seems to have worked out OK: ${url}"
elapsed
#ddev-live delete site ${SITENAME}
# Add curls here to wait for it to come up and check some content.
