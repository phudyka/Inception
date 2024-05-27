#!/bin/bash

php-fpm7.3 -D

until mysqladmin ping -h mariadb --silent; do
    echo "Waiting for MariaDB to be available..."
    sleep 2
done

cd /var/www/wordpress

wp config create --dbname="$SQL_DATABASE" --dbuser="$SQL_USER" --dbpass="$SQL_PASSWORD" --dbhost="mariadb" --path=/var/www/wordpress --allow-root

wp core install --url="http://localhost" --title="My WordPress Site" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path=/var/www/wordpress --allow-root

php-fpm7.3 -F
