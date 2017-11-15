# git-crypt-team

Handle key updates for git-crypt repos by sourcing key IDs from a JSON file on S3.

## Installation

Requirements:
* [gpg](https://www.gnupg.org/)
* [aws-cli](https://aws.amazon.com/cli/)
* [git-crypt](https://github.com/AGWA/git-crypt)
* [jq](https://stedolan.github.io/jq/)

```
sudo make install
```


## Config

The first time you run git-crypt-team on a repo, you need to provide the team file's S3 URL. If that file doesn't currently exist, include the `-e` flag so that you can create it.

```
$ git-crypt-team -u s3://somebucket/somepath/somefile.json -e
```

Example team file:
```json
[
  {
    "key": "BDE148ED",
    "email": "shaun@samsite.ca"
  },
  {
    "key": "B58C5FE0"
  }
]
```

After that first run, the URL will be stored in `.git-crypt-team/url`. The current team file will be uploaded to S3 and cached at `.git-crypt-team/teamfile`.

## Usage



```
git-crypt-team [-h] [-u S3 url] [-s] [-p] -v|e|r

Rekey git-crypt'd repo with a userlist stored in S3

Operations - defaults to -v
  -v    - Download and view the latest team list, then exit.
  -e    - Download and edit the team list, optionally upload changes to S3, then exit.
  -r    - Rekey the repo using the latest team list from S3.

Options
  -f    - Force the rekey operation
  -p    - Preserve unencrypted backups. Only valid with -r
  -s    - Skip remote git operations (ie: push & pull).
  -u    - S3 URL for the team list. eg: s3://somebucket/somepath/somefile.json Only required on first run.
  -h    - Print this help and exit.
```

### Docker

An CentOS-based Docker image with git-crypt bundled is built and available at `inhumantsar/git-crypt-team`. If you mount your repo at `/workspace`, you can use git-crypt-team directly. eg:

```
$ docker run --rm -it \
    -w /workspace -v $(pwd):/workspace \
    inhumantsar/git-crypt-team git-crypt-team -v
```

## Development

### Requirements
* [bats](https://github.com/sstephenson/bats)

### Versioning

Standard semantic versioning: `major.minor.patch`
* _Major_: Big new chunks of functionality, breaks backward compatibility.
* _Minor_: Enhancements to current functionality.
* _Patch_: Non-breaking security updates, bugfixes, and cosmetic changes.

*_Always update the `VERSION` file when starting on new work_*

### Packaging

Example: GitLab CI

```yaml
build:
  image: inhumantsar/fpm-pkg
  script:
    # packag binary into an rpm
    - fpm -s dir -t rpm -n "git-crypt-team" -v `cat $CI_PROJECT_DIR/VERSION` \
        -f --prefix /usr/bin .

    # push to artifactory
    - curl -u"ciwriter:$ARTIFACTORY_CIWRITER_TOKEN" \
        -XPUT http://artifactory.domain.ca/artifactory/centos-local/ -T /output/*.rpm
```

## Testing

Requires [bats](https://github.com/sstephenson/bats). Each test tries different inputs and attempts to touch on ever success and error state imaginable (within reason of course).

Currently, these are totally broken. Don't bother.
