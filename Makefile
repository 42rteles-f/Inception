COLOR_RESET =	\033[0m
COLOR_GREEN =	\033[32m

# /data/ folder for (Data Persistence), and (Docker Volume Binding)
all:
	@mkdir -p $$HOME/data/wordpress/;
	@mkdir -p $$HOME/data/mariadb/;
	@echo "[$(COLOR_GREEN)info$(COLOR_RESET)]: Created /data/"
	@docker compose -f ./srcs/docker-compose.yaml up -d --build
	@echo "[$(COLOR_GREEN)info$(COLOR_RESET)]: Compose Up"

down:
	@docker compose -f ./srcs/docker-compose.yaml down
	@echo "[$(COLOR_GREEN)info$(COLOR_RESET)]: Compose Down"

re: fclean all

fclean: clean
	@sudo rm -rf $$HOME/data;
	@echo "[$(COLOR_GREEN)info$(COLOR_RESET)]: Removed /data/"

clean:
	@docker rm -f $$(docker ps -aq)
	@docker system prune -a -f --volumes
	@echo "[$(COLOR_GREEN)info$(COLOR_RESET)]: Docker Clean"

# docker ps: List running containers
# 	-a: List all containers
#	-q: Quiet Mode, list only the ID's

# docker rm -f: force stops and removes all containers
# docker system prune -a -f --volumes: Removes all unused containers, images, networks, build cache and volumes.