COLOR_RESET =	\033[0m
COLOR_GREEN =	\033[32m

# /data/ folder for (Data Persistence), and (Docker Volume Binding)
all:
	@mkdir -p /home/rteles-f/data/wordpress/;
	@mkdir -p /home/rteles-f/data/mariadb/;
	@echo "[$(COLOR_GREEN)info$(COLOR_RESET)]: Created /data/"
	@docker-compose -f ./srcs/docker-compose.yaml up -d --build > /dev/null
	@echo "[$(COLOR_GREEN)info$(COLOR_RESET)]: Compose Up"

down:
	@docker-compose -f ./srcs/docker-compose.yaml down > /dev/null
	@echo "[$(COLOR_GREEN)info$(COLOR_RESET)]: Compose Down"

re: fclean all

fclean: clean
	@sudo rm -rf /home/rteles-f/data;
	@echo "[$(COLOR_GREEN)info$(COLOR_RESET)]: Removed /data/"

clean:
	@if [ -n "$$(docker ps -aq)" ]; then docker rm -f $$(docker ps -aq) > /dev/null; fi
	@docker system prune -a -f --volumes > /dev/null
	@@if [ -n "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q) > /dev/null; fi
	@echo "[$(COLOR_GREEN)info$(COLOR_RESET)]: Docker Clean"

# docker ps: List running containers
# 	-a: List all containers
#	-q: Quiet Mode, list only the ID's

# docker rm -f: force stops and removes all containers
# docker system prune -a -f --volumes: Removes all unused containers, images, networks, build cache and volumes.

# check nginx ports
# sudo netstat -tulnp | grep nginx
# ss -tulnp | grep nginx
