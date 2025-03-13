FROM debian:bullseye

RUN apt-get update -y && \
	apt-get install php php7.4-fpm curl php-mysql mariadb-client -y
# Installs the default PHP version available in the repository.
# php7.4-fpm → Installs PHP 7.4 with FastCGI Process Manager (FPM). This is used to handle PHP requests efficiently, typically in an Nginx or Apache setup.
# curl → A command-line tool used for making HTTP requests, often required for scripts that interact with APIs or external resources.
# php-mysql → The PHP extension required to connect PHP applications to a MySQL or MariaDB database.
# mariadb-client → The command-line client for MariaDB, allowing the container to interact with a remote MariaDB database.
# netcat → A networking utility used for debugging and testing network connections. It can be helpful for checking if a service (like a database) is reachable.
# -y → Automatically answers "yes" to all installation prompts, ensuring a smooth installation without user intervention

RUN mkdir -p /var/www/wordpress

COPY ./config/wordpress-conf.sh ./

RUN chmod +x /wordpress-conf.sh && \
	sh -c /wordpress-conf.sh

CMD ["/usr/sbin/php-fpm7.4", "-F"]
