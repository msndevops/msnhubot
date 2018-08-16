
SHELL:=/bin/bash
PATH:=node_modules/.bin:node_modules/hubot/node_modules/.bin:$(PATH)
ENVFILE:=environment
COFFEE:=node_modules/hubot/node_modules/.bin/coffee

# Standard Variables
SYSCONFDIR=$(PREFIX)/etc
VARDIR=$(PREFIX)/var
INITDIR=$(SYSCONFDIR)/systemd/system
INSTALL=/bin/install -p

build:
	docker build -t msndevopsbot .

docker:
	docker run -v $(shell pwd):/var/lib/hubot -p 8000:8000 -it msndevopsbot bin/hubot

slack:
	docker run -v $(shell pwd):/var/lib/hubot -p 8000:8000 -it msndevopsbot bin/hubot --adapter slack

dockershell:
	docker run -v $(shell pwd):/var/lib/hubot -p 8000:8000 -it msndevopsbot /bin/bash


all: lint test

debuginfo:
	node -v
	npm version

test: node_modules syntax unit
  # If you have a secrets file, load it into your shell on your own
  # Currently, a secrets file isn't needed for tests.

unit:
	PATH=$(PATH) . $(ENVFILE) > /dev/null && test -d $${HUBOT_GIT_HOME} || HUBOT_GIT_HOME=$(shell pwd) &&  mocha --compilers "coffee:coffee-script/register" --require coffee-script/register test/*.coffee

syntax: node_modules
	PATH=$(PATH) . $(ENVFILE) > /dev/null  && $(COFFEE) node_modules/hubot/bin/hubot -t

node_modules:
	test -d node_modules || npm install

lint: node_modules
	PATH=$(PATH) beautify-lint scripts/*.js

# Warning this will modify source code. Don't run this in CI. It's here as a helper.
pretty: node_modules
	PATH=$(PATH) beautify-rewrite scripts/*.js

dev: node_modules
  # If you have a secrets file, load it into your shell on your own
	PATH=$(PATH) . $(ENVFILE) > /dev/null &&  HUBOT_LOG_LEVEL=debug $(COFFEE) node_modules/hubot/bin/hubot --alias "!"

production-modules:
	npm prune && npm install

.PHONY: list
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

clean:
	clear
