FROM debian:buster

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y wget php7.3 php-fpm php-mysql mariadb-client curl unzip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require wp-cli/wp-cli-bundle

ENV PATH="/root/.composer/vendor/bin:${PATH}"

RUN wget https://fr.wordpress.org/wordpress-6.4.4-fr_FR.tar.gz -P /var/www \
    && cd /var/www && tar -xzf wordpress-6.4.4-fr_FR.tar.gz && rm wordpress-6.4.4-fr_FR.tar.gz \
    && chown -R www-data:www-data /var/www/wordpress

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

COPY tools/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh
RUN mkdir /run/php

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
