all: volumes
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

re: fclean all

volumes:
	mkdir -p $$HOME/data/wordpress/;
	mkdir -p $$HOME/data/mariadb/;

fclean: clean
	- sudo rm -rf $$HOME/data;

env:
	@touch .env
	@cat << EOF > .env
DATABASE_USER=inceptionuser
DATABASE_PASSWORD=inceptionpassword
DATABASE_NAME=inceptiondatabase
DATABASE_HOST=mariadb
DATABASE_PORT=3306

DOMAIN=rteles-f.42.fr

BACKEND_ADMIN=mad-rteles-f
BACKEND_ADMIN_PASSWORD=mad-rteles-f
BACKEND_ADMIN_EMAIL=mad-rteles-f@example.com
BACKEND_USER=rteles-f
BACKEND_USER_PASSWORD=rteles-f
BACKEND_USER_EMAIL=rteles-f@example.com
EOF


clean:
	- docker stop $$(docker ps -a -q)
	- docker rm $$(docker ps -a -q)
	- docker rmi $$(docker images -q)
	- docker volume rm $$(docker volume ls -q)
	- docker network rm $$(docker network ls -q)
	- docker system prune -a -f