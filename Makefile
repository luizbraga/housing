APP_NAME=housing
docker-compose-dev=docker-compose -f docker-compose.dev.yml

KNOWN_TARGETS=dev-exec
ARGS:=$(filter-out $(KNOWN_TARGETS),$(MAKECMDGOALS))

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


install: ## Install pip dependencies for the API
	${PIP} install -r requirements.txt

run: ## Start API server
	${PYTHON} manage.py runserver

clean_pyc: ## Delete all .pyc files
	find -name "*.pyc" -delete



# DOCKER COMMANDS

dev-build: ## Build develoment container
	$(docker-compose-dev) build --no-cache
	$(docker-compose-dev) up -d

dev-up: ## Run all dev containers
	$(docker-compose-dev) up -d

dev-down: ## Stop all dev containers
	$(docker-compose-dev) down

dev-restart: ## Restart all dev containers
	$(docker-compose-dev) restart

dev-clean: ## Stop all dev containers and remove volume, image and network
	$(docker-compose-dev) down -v --rmi all

dev-exec: ## Run command in API container, such as "make test"
	$(docker-compose-dev) exec web $(ARGS)
