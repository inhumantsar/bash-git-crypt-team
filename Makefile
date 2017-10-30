.PHONY : all test install

PREFIX = "/usr/local/bin"

install:
	cp git-crypt-team "${PREFIX}/"

# test:
# 	bats git-crypt-team.bats
# 
# all: test
