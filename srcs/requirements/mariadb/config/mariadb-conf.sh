#! /usr/bin/env bash

if [ -d "/var/lib/mysql/${DATABASE_NAME}" ]; then
	echo "enter if $?" >> output.txt
	exit 0;	
fi

service mariadb start

# mariadb -u root -e "
# CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};
# CREATE USER IF NOT EXISTS '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASS}';
# GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${DATABASE_USER}'@'%';
# FLUSH PRIVILEGES;"

mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};"
mariadb -u root -e "CREATE USER IF NOT EXISTS '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASS}';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${DATABASE_USER}'@'%';"
mariadb -u root -e "FLUSH PRIVILEGES;"

echo "status $?" >> output.txt

service mariadb stop
