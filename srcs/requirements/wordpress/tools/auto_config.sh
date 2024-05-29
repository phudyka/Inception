#!/bin/bash

sleep 10

if [ -f /var/www/wordpress/wp-config.php ]; then
    echo "WordPress already initialized"
else
    echo "Creating wp-config.php"
    wp config create --allow-root \
                     --dbname="${MYSQL_DATABASE}" \
                     --dbuser="${MYSQL_USER}" \
                     --dbpass="${MYSQL_PASSWORD}" \
                     --dbhost="mariadb:3306" \
                     --path='/var/www/wordpress'

    wp core install --allow-root \
                    --url="${WORDPRESS_URL}" \
                    --title="${WORDPRESS_TITLE}" \
                    --admin_user="${WORDPRESS_ADMIN_USER}" \
                    --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
                    --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
                    --path='/var/www/wordpress'

    wp user create "${WORDPRESS_ADMIN_USER}" "${WORDPRESS_ADMIN_EMAIL}" --role=author --user_pass="${WORDPRESS_ADMIN_PASSWORD}" --path='/var/www/wordpress' --allow-root
fi

mkdir -p /run/php

exec /usr/sbin/php-fpm7.3 -F