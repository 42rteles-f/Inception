#! /usr/bin/env bash

if [ -d "/var/lib/mysql/${DATABASE_NAME}" ]; then
	exit 0;	
fi

service mariadb start

mariadb -u root -e "
CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};
CREATE USER IF NOT EXISTS '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASS}';
GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${DATABASE_USER}'@'%';
FLUSH PRIVILEGES;"

if [ $? -eq 0 ]; then
    echo "✅ Database and user were successfully created!"
else
    echo "❌ Error: Failed to create database/user!"
fi

service mariadb stop
