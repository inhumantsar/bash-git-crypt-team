#!/bin/sh
SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")

PKG_NAME='git-crypt-team'
SUMMARY="Centralized key management and rekeying for teams using git-crypt."
URL="https://github.com/inhumantsar/bash-git-crypt-team"
MAINTAINER="Shaun Martin <shaun@samsite.ca>"

fpm -s dir -t rpm -f -C $DIR \
  -n $PKG_NAME --prefix /usr/bin \
  -v "$(cat ${DIR}/VERSION)" -a noarch \
  -m "${MAINTAINER}" --vendor "${MAINTAINER}" -d git -d gpg -d jq \
  --description "$(cat ${DIR}/README.md)" \
  --rpm-summary "${SUMMARY}" \
  --url "$URL" --license BSD git-crypt-team
