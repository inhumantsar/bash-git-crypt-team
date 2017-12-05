#!/bin/sh
SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")

PKG_NAME='git-crypt-team'
SUMMARY="Centralized key management and rekeying for teams using git-crypt."
URL="https://github.com/inhumantsar/bash-git-crypt-team"
MAINTAINER="Shaun Martin <shaun@samsite.ca>"

fpm -s dir -t deb -f -C $DIR \
  -n $PKG_NAME --prefix /usr/bin \
  -v "$(cat VERSION)" -a noarch \
  -m "${MAINTAINER}" --vendor "${MAINTAINER}" -d git -d gnupg -d jq \
  --description "$(cat README.md)" \
  --url "$URL" --license BSD git-crypt-team
