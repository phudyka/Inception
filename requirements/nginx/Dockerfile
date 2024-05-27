FROM debian:buster

RUN apt update && \
    apt upgrade -y && \
    apt install -y nginx vim curl openssl && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /etc/nginx/ssl /var/run/nginx && \
    chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Nice/O=42/OU=42/CN=phudyka.42.fr/UID=phudyka"

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]