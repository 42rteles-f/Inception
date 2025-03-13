FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install mariadb-server -y

COPY ./config/mariadb-conf.sh ./

RUN chmod +x /mariadb-conf.sh && \
    touch sh_executed && \
    sh -c ./mariadb-conf.sh

CMD ["mysqld_safe", "--bind-address=0.0.0.0", "--port=3306", "--socket=/run/mysqld/mysqld.sock"]
