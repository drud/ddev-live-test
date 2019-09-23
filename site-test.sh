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
SITENAME="d8composer-test-$(date +%Y%m%d%H%M%S)"

function cleanup {
    echo "Here are the cleanup actions"
}
trap cleanup EXIT

# Consider downloading and installing latest ddev-live-client and using it.

echo "Creating site ${SITENAME}"
ddev-live create site drupal ${SITENAME} --github-repo=${GITHUB_REPO} --run-composer-install
