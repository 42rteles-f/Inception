#! /usr/bin/env bash

if [ -d "/var/lib/mysql/${DATABASE_NAME}" ]; then
	exit 0;	
fi

service mariadb start
sleep 5

mariadb -u root -e "
	CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};
	CREATE USER IF NOT EXISTS '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASS}';
	GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${DATABASE_USER}'@'%';
	FLUSH PRIVILEGES;
"

if [ $status -eq 0 ]; then
    echo "✅ Success! Exit code: $status" >> dbanswer
else
    echo "❌ Error! Exit code: $status" >> dbanswer
fi

service mariadb stop
