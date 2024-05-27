FROM debian:buster

# Paquets
RUN apt update && \
    apt upgrade -y && \
    apt install -y wget php7.3 php-fpm php-mysql mariadb-client && \
    apt clean

# WordPress
RUN wget https://fr.wordpress.org/wordpress-6.5.3-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.5.3-fr_FR.tar.gz && rm wordpress-6.5.3-fr_FR.tar.gz
RUN chown -R root:root /var/www/wordpress

# WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# PHP-FPM
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

EXPOSE 9000

# Config WordPress et WP-CLI
COPY conf/wp-config.sh /usr/local/bin/wp-config.sh
RUN chmod +x /usr/local/bin/wp-config.sh

# Commande par défaut pour démarrer PHP-FPM
CMD ["/usr/local/bin/wp-config.sh"]
