dev = dev
docker_compose_dev = docker-compose -f docker-compose.dev.yml
test = test
docker_compose_test = docker-compose -f docker-compose.test.yml
bundle_exec = bundle exec
rake = bundle exec rake
# Use uppercase PWD not lowercase pwd here, otherwise it will not work.

# ---- #
# Lint #
# ---- #
rubocop:
	$(docker_compose_dev) run --rm web $(bundle_exec) rubocop .

# TODO:
# - markdownlint
# - yamllint

lint: rubocop

# ---- #
# Dev. #
# ---- #

# Docker basics
dev-up:
	$(docker_compose_dev) up -d

dev-down:
	$(docker_compose_dev) down

dev-build:
	$(docker_compose_dev) build

dev-start:
	$(docker_compose_dev) start web

dev-stop:
	$(docker_compose_dev) stop web

# Database basics
dev-db-create:
	$(docker_compose_dev) run --rm web $(rake) db:create

dev-db-drop:
	$(docker_compose_dev) run --rm web $(rake) db:drop

dev-db-migrate:
	$(docker_compose_dev) run --rm web $(rake) db:migrate

dev-db-seed:
	$(docker_compose_dev) run --rm web $(rake) db:seed

# Smart tools
dev-reset: dev-stop dev-db-drop dev-db-create dev-db-migrate dev-db-seed dev-start

dev-new-env: dev-down dev-build dev-up dev-reset

# ---- #
# Test #
# ---- #

# Docker basics
test-up:
	$(docker_compose_test) up -d

test-down:
	$(docker_compose_test) down

test-build:
	$(docker_compose_test) build

test-start:
	$(docker_compose_test) start web

test-stop:
	$(docker_compose_test) stop web

# Database basics
test-db-create:
	$(docker_compose_test) run --rm web $(rake) db:create

test-db-drop:
	$(docker_compose_test) run --rm web $(rake) db:drop

test-db-migrate:
	$(docker_compose_test) run --rm web $(rake) db:migrate

test-db-seed:
	$(docker_compose_test) run --rm web $(rake) db:seed

test-rspec:
	$(docker_compose_test) run -rm web $(bundle_exec) rspec

# Smart tools
test-new-env: test-down test-build test-up test-reset

test-reset: test-stop test-db-drop test-db-create test-db-migrate test-db-seed test-start

test-rebuild: test-new-env test-rspec

test: test-reset test-rspec

# -------------- #
# All the checks #
# -------------- #
lint-and-test: lint test

.PHONY: lint rubocop dev-up dev-down dev-build dev-start dev-stop dev-db-create dev-db-drop dev-db-migrate dev-db-seed dev-reset dev-new-env test-up test-down test-build test-start test-stop test-db-create test-db-drop test-db-migrate test-db-seed test-rspec test-new-env test-reset test-rebuild test
