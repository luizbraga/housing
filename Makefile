ifeq (test, $(firstword $(MAKECMDGOALS)))
  runargs := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
  $(eval $(runargs):;@true)
endif

APP_NAME=housing

KNOWN_TARGETS=docker-exec
ARGS:=$(filter-out $(KNOWN_TARGETS),$(MAKECMDGOALS))

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


install: ## Install pip dependencies for the API
	pip install -r requirements.dev.txt

run: ## Start API server
	python src/manage.py runserver --settings=housing.settings

clean_pyc: ## Delete all .pyc files
	find -name "*.pyc" -delete



# DOCKER COMMANDS

build: ## Build develoment container
	docker build -t luizbraga/housing:local .

up: ## Run all dev containers
	docker-compose up -d

down: ## Stop all dev containers
	docker-compose down

restart: ## Restart all dev containers
	docker-compose restart

docker-clean: ## Stop all dev containers and remove volume, image and network
	docker-compose down -v --rmi all

docker-exec: ## Run command in API container, such as "make test"
	docker-compose exec webserver $(ARGS)
