#! /usr/bin/env bash

if [ ! -d "/var/lib/mysql/${DATABASE_NAME}" ]; then
	service mariadb start

	mariadb -u root -e "
		CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};
		CREATE USER IF NOT EXISTS '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASS}';
		GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${DATABASE_USER}'@'%';
		ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'rootpass';
		ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'rootpass';
		FLUSH PRIVILEGES;
	"

	service mariadb stop
fi

exec mysqld_safe --bind-address=0.0.0.0 --port=3306 --socket=/run/mysqld/mysqld.sock
