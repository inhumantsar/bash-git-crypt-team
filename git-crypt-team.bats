#!/usr/bin/env bats

#############################################################
# NOTE: NONE OF THIS ACTUALLY WORKS.
#       `bats` doesn't seem to like working outside `pwd`
#############################################################

TEST_URL="s3://samsite.ca/tmp/test.json"
TEST_PATH="$BATS_TMPDIR/test-repo"

setup() {
  # set up fake repo to test against
  prevdir=$(pwd)
  mkdir -p $TEST_PATH &> /dev/null
  echo "plain text" > $TEST_PATH/plainfile
  echo "secret text" > $TEST_PATH/secretfile
  echo "secretfile filter=git-crypt diff=git-crypt" > $TEST_PATH/.gitattributes
  rm -rf $TEST_PATH/.git $TEST_PATH/.git-crypt*
  cd $TEST_PATH && git init; cd $prevdir

  # this lets us use a public s3 file w/o setting up creds
  # more info: https://github.com/aws/aws-cli/issues/904
  mv /usr/bin/aws /usr/bin/aws-orig
  echo '/usr/bin/aws-orig --no-sign-request $@' > /usr/bin/aws
  chmod +x /usr/bin/aws
}

# teardown() {
# }

# @test "running ./git-crypt without a url returns an error" {
#   run cd $TEST_PATH && git-crypt-team
#   [ $status -eq 1 ]
#   [ "$output" = *"ERROR: No URL passed or stored in config. Use -u."* ]
# }

# @test "running ./git-crypt with a url returns json" {
#   run cd $TEST_PATH && git-crypt-team -u s3://samsite.ca/tmp/test.json | head -n 1
#   [ "$status" -eq 0 ]
# }


# @test "running ./sample-app with a blank url returns an error" {
#   run ./sample-app -u ""
#   [ "$status" -eq 1 ]
#   [ "$output" = "ERROR: URL is blank" ]
# }
#
# @test "running ./sample-app with a non-wikipedia url returns an error" {
#   run ./sample-app -u http://moo.moo/moo
#   [ "$status" -eq 1 ]
#   [ "$output" = "ERROR: Not a Wikipedia URL" ]
# }
#
# @test "running ./sample-app without an argument for -u returns an error" {
#   run ./sample-app -u
#   [ "$status" -eq 1 ]
#   [ "$output" = "./sample-app: option requires an argument -- u" ]
# }
#
# @test "running ./sample-app without an argument for -r returns an error" {
#   run ./sample-app -r
#   [ "$status" -eq 1 ]
#   [ "$output" = "./sample-app: option requires an argument -- r" ]
# }
#
# @test "running ./sample-app with an unknown option returns an error" {
#   run ./sample-app -z
#   [ "$status" -eq 1 ]
#   [ "$output" = "./sample-app: illegal option -- z" ]
# }
#
# @test "running ./sample-app with -h returns usage help" {
#   run ./sample-app -h
#   [ "$status" -eq 0 ]
#   [ "${lines[0]}" = "./sample-app [-h] [-v] [-u url] [-r regex]" ]
# }
#
# @test "running ./sample-app with no options returns content" {
#   run ./sample-app
#   [ "$status" -eq 0 ]
#   [ "$output" != "" ]
# }
#
# @test "running ./sample-app in verbose mode succeeds" {
#   run ./sample-app -v
#   [ "$status" -eq 0 ]
#   [ "$output" != "" ]
# }
#
# @test "running ./sample-app with a wikipedia url returns content" {
#   run ./sample-app -u https://en.wikipedia.org/wiki/Roland_TR-808
#   [ "$status" -eq 0 ]
#   [ "$output" != "" ]
# }
#
# @test "running ./sample-app with custom regex returns content" {
#   run ./sample-app -r 's/.*/moo/g'
#   [ "$status" -eq 0 ]
#   [ "$output" != "" ]
# }
