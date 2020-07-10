SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# brew install shellcheck parallel

.PHONY: all
all: run-drupal run-typo3 run-wordpress

.PHONY: check
check:
	# Fail if any of these files have warnings
	shellcheck *.sh

.PHONY: run-drupal
run-drupal:
	parallel ./drupal.sh ::: {7..9}

.PHONY: run-typo3
run-typo3:
	parallel ./typo3.sh ::: {9..10}

.PHONY: run-wordpress
run-wordpress:
	parallel ./wordpress.sh ::: {54..54}
