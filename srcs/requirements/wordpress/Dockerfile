FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && apt-get install php php7.4-fpm curl php-mysql mariadb-client netcat -y

RUN mkdir -p /var/www/wordpress

COPY ./conf/wp-conf.sh /

RUN chmod +x /wp-conf.sh

ENTRYPOINT [ "./wp-conf.sh" ]