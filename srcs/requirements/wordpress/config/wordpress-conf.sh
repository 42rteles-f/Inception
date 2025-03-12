#! /usr/bin/env bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

cd /var/www/wordpress

chmod -R 755 /var/www/wordpress

chown -R www-data:www-data /var/www/wordpress

echo "Database connections established."

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "Installing WordPress..."
    wp core download --allow-root
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST:$DB_PORT --allow-root
    wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_PASS --admin_email=$WP_EMAIL --skip-email --allow-root
    wp user create $WP_U_NAME $WP_U_EMAIL --user_pass=$WP_U_PASS --role=$WP_U_ROLE --allow-root
fi

echo "WordPress is installed."

sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F