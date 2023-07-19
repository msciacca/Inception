NAME = inception

$(NAME): run

run:
	docker compose -f srcs/docker-compose.yml up

down:
	docker compose -f srcs/docker-compose.yml down

vclean:
	docker volume rm -f srcs_wordpress_data
	docker volume rm -f srcs_mariadb_data

iclean:
	docker image rm i-mariadb:1.0.0
	docker image rm i-wordpress:1.0.0
	docker image rm i-nginx:1.0.0
	docker image rm i-adminer:1.0.0
	docker image rm i-grafana:1.0.0
	docker image rm i-redis:1.0.0
	docker image rm i-ftp:1.0.0
	docker image rm i-static_website:1.0.0

clean: vclean iclean

fclean: down clean

re: fclean run
