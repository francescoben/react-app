uname_S := $(shell uname -s)

all: build up

build:
	docker-compose build

up:
	docker-compose down -v
	docker-compose up -d

cli:
	docker-compose exec app bash

logs:
	docker-compose logs -f

app-build:
	docker-compose exec app npm run build

app-start:
	docker-compose exec app npm start
