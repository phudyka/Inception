FROM debian:buster

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y wget php7.3 php-fpm php-mysql mariadb-client && \
    apt clean

RUN wget https://fr.wordpress.org/wordpress-6.4.4-fr_FR.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf wordpress-6.4.4-fr_FR.tar.gz && \
    rm wordpress-6.4.4-fr_FR.tar.gz && \
    chown -R www-data:www-data /var/www/wordpress

COPY conf/www.conf /etc/php/7.3/fpm/pool.d

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY tools/auto_config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/auto_config.sh

RUN mkdir -p /run/php

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
