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
#GITHUB_REPO=rfay/d8composer
#SITENAME="d8composer-test-$(date +%Y%m%d%H%M%S)"
GITHUB_REPO=rfay/d8composer
SITE_BASENAME=d8composer
SITENAME="${SITE_BASENAME}-$(date +%Y%m%d%H%M%S)"

function cleanup {
    set +x
    echo "This would do cleanup actions including 'ddev-live delete site ${SITENAME}' at this point"
    #ddev-live delete site ${SITENAME}
}
trap cleanup EXIT

# Consider downloading and installing latest ddev-live-client and using it.

echo "Creating site ${SITENAME}"
ddev-live create site drupal ${SITENAME} --github-repo=${GITHUB_REPO} --run-composer-install --docroot web
#ddev-live create site drupal ${SITENAME} --github-repo=${GITHUB_REPO} --drupal-version 7 --branch 7.x

./wait_site_healthy.sh ${SITENAME}
echo -ne '\007' >&2

ddev-live push db ${SITENAME} assets/${SITE_BASENAME}.sql.gz
pushd assets/${SITE_BASENAME}
ddev-live push files ${SITENAME} .
popd

