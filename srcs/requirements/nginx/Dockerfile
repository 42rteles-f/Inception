FROM debian:bullseye

RUN apt-get update -y && \
	apt-get install nginx openssl -y && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl/certs /etc/nginx/ssl/keys /var/www/wordpress && \
	chown -R www-data:www-data /var/www/wordpress

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/nginx/ssl/keys/nginx-selfsigned.key \
		-out /etc/nginx/ssl/certs/nginx-selfsigned.crt \
		-subj "/C=${COUNTRY}/ST=${STATE}/L=${CITY}/O=${ORG}/OU=${UNIT}/CN=${DOMAIN}"
		# -subj "/C=PT/ST=Lisboa/L=Lisboa/O=42/OU=42/CN=rteles-f.42.fr"
# Add env variables

COPY ./config/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
