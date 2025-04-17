WP_DATA = /home/sumseo/data/wordpress
DB_DATA = /home/sumseo/data/mariadb

all: up

up: build
		@mkdir -p $(WP_DATA)
		@mkdir -p $(DB_DATA)
		@docker compose -f srcs/docker-compose.yml up -d

down:
		@docker compose -f srcs/docker-compose.yml down

stop:
		@docker compose -f srcs/docker-compose.yml stop

start:
		@docker compose -f srcs/docker-compose.yml start

build:
		@docker compose -f srcs/docker-compose.yml build


clean:
		@docker stop $$(docker ps -qa) || true
		@docker rm $$(docker ps -qa) || true
		@docker rmi -f $$(docker images -qa) || true
		@docker volume rm $$(docker volume ls -q) || true
		@docker network rm $$(docker network ls -q) || true
		@rm -rf $(WP_DATA) || true
		@rm -rf $(DB_DATA) || true

re: clean up

prune: clean
		@docker systemp prune -a --volumes -f