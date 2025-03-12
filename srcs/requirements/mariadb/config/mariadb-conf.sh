#! /usr/bin/env bash

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
	
	# Initializes the mariadb and waits 5 seconds to let the service load up.
	service mariadb start
	sleep 5

	mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"

	mariadb -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"

	mariadb -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"

	mariadb -u root -e "FLUSH PRIVILEGES;"

	service mariadb stop
fi

# Runs the mariadb in safe mode
mysqld_safe --bind-address=0.0.0.0 --port=3306 --socket=/run/mysqld/mysqld.sock
