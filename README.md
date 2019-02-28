# Housing :house:
[![CircleCI](https://circleci.com/gh/luizbraga/housing.svg?style=svg)](https://circleci.com/gh/luizbraga/housing)

Simple house keeper application, where we can store things we forgot constantly

### Dependencies
* Python 3.6.0
* Postgres 9.6
* Docker Engine >= 17.12.0

### Development
* Run `make install` to install dependencies
* Create and set `.env` file based on `.env-example`
* Run `make run` to run the server **without** Docker

#### Running with Docker
* Run `make dev-build` to create the project image
* Run `make dev-up` to start all containers listed in `docker-compose.dev.yml`
