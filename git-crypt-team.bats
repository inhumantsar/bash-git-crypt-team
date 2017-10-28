#!/usr/bin/env bats

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
