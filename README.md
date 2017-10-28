# git-crypt-team

Handle key updates for git-crypt repos by sourcing key IDs from a JSON file on S3.

## Usage

```
git-crypt-team [-h] [-u S3 url] [-s] [-p] -v|e|r

Rekey git-crypt'd repo with a userlist stored in S3

Operations - defaults to -v
  -v    - Download and view the latest team list, then exit.
  -e    - Edit the team list and upload it to S3.
  -r    - Rekey the repo using the latest team list from S3.

Options
  -u    - S3 URL for the team list. Only required on first run.
  -p    - Preserve unencrypted backups. Only valid with -r
  -s    - Skip remote git operations (ie: push & pull).
  -h    - Print this help and exit.
```

## Development

### Versioning

Standard semantic versioning: `major.minor.patch`
* _Major_: Big new chunks of functionality, breaks backward compatibility.
* _Minor_: Enhancements to current functionality.
* _Patch_: Non-breaking security updates, bugfixes, and cosmetic changes.

*_Always update the `VERSION` file when starting on new work_*

### Packaging

GitLab CI is set up to run a packaging step which generates an RPM using `fpm` and submits that to Artifactory.

```yaml
build:
  script:
    # install fpm TODO: use an image with fpm baked in
    - apk --no-cache add alpine-sdk ruby ruby-dev ruby-irb ruby-rdoc libffi-dev
    - gem install fpm

    # package binary into an rpm
    - fpm -s dir -t rpm -n "sample-app" -v `cat $CI_PROJECT_DIR/VERSION` -f --prefix /usr/bin .

    # push to artifactory
    - curl -u"ciwriter:$ARTIFACTORY_CIWRITER_TOKEN" -XPUT http://artifactory.wlnpcc.ca/artifactory/centos-local/ -T /output/*.rpm
```

## Testing

Requires [bats](https://github.com/sstephenson/bats). Each test tries different inputs and attempts to touch on ever success and error state imaginable (within reason of course).

The test syntax is *bash-like*, but is importantly not bash. For example, tests can't use regex compares (=~). There are three special variables you can use:
* `status` - exit code
* `output` - stdout as one big string
* `lines[]` - stdout broken up into an array of lines

```bash
@test "running ./sample-app with a non-wikipedia url returns an error" {
  run ./sample-app -u http://moo.moo/moo
  [ "$status" -eq 1 ]
  [ "$output" = "ERROR: Not a Wikipedia URL" ]
}
```

```
  $ bats *.bats
   ✓ running ./sample-app with a blank url returns an error
   ✓ running ./sample-app with a non-wikipedia url returns an error
   ✓ running ./sample-app without an argument for -u returns an error
   ✓ running ./sample-app without an argument for -r returns an error
   ✓ running ./sample-app with an unknown option returns an error
   ✓ running ./sample-app with -h returns usage help
   ✓ running ./sample-app with no options returns content
   ✓ running ./sample-app in verbose mode succeeds
   ✓ running ./sample-app with a wikipedia url returns content
   ✓ running ./sample-app with custom regex returns content

  10 tests, 0 failures
```
