FROM debian:buster

# Installer les paquets nécessaires
RUN apt update && \
    apt upgrade -y && \
    apt install -y wget php7.3 php-fpm php-mysql mariadb-client && \
    apt clean

# Télécharge et extraire WordPress
RUN wget https://fr.wordpress.org/wordpress-6.5.3-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.5.3-fr_FR.tar.gz && rm wordpress-6.5.3-fr_FR.tar.gz
RUN chown -R root:root /var/www/wordpress

# Télécharge et installer WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Copie la configuration PHP-FPM
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# Copie le script de configuration auto_config.sh
COPY conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

# Expose le port
EXPOSE 9000

# Définit l'ENTRYPOINT pour exécuter le script de configuration
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]