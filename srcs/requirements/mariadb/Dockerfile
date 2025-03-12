FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install mariadb-server -y

COPY ./config/mariadb-conf.sh ./

RUN chmod +x /mariadb-conf.sh

ENTRYPOINT [ "./mariadb-conf.sh" ]
