#! /usr/bin/env bash

exec > /dev/null

if [ ! -d "/var/lib/mysql/${DATABASE_NAME}" ]; then
	
	# Initializes the mariadb and waits 5 seconds to let the service load up.
	service mariadb start
	sleep 5

	mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};"

	mariadb -u root -e "CREATE USER IF NOT EXISTS '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASS}';"

	mariadb -u root -e "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${DATABASE_USER}'@'%';"

	mariadb -u root -e "FLUSH PRIVILEGES;"

	service mariadb stop
fi

# Runs the mariadb in safe mode
mysqld_safe --bind-address=0.0.0.0 --port=3306 --socket=/run/mysqld/mysqld.sock
