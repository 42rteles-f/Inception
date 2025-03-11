#!/bin/bash

if [ -d "/var/lib/mysql/$DATABASE_NAME" ] then
    echo "Database already exists"
    exec mysqld_safe --bind-address=0.0.0.0
    exit 0
fi

# Open MariaDB terminal
service mariadb start

sleep 5

# Type the commands manually in the terminal
mysql -e "CREATE DATABASE ${DATABASE_NAME};"
mysql -e "CREATE USER '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON mydatabase.* TO '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

sleep 5

# Close MariaDB terminal
service mariadb stop

# Start MariaDB Server
exec mysqld_safe --bind-address=0.0.0.0