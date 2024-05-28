#!/bin/bash

# Pause pour s'assurer que la base de données est prête
sleep 10

# Vérifie si wp-config.php n'existe pas déjà
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    # Utilise WP-CLI pour créer le fichier de configuration de WordPress
    wp config create --allow-root \
                     --dbname=$SQL_DATABASE \
                     --dbuser=$SQL_USER \
                     --dbpass=$SQL_PASSWORD \
                     --dbhost=mariadb:3306 --path='/var/www/wordpress'
                     
    # Installe WordPress et configurer l'administrateur
    wp core install --url="http://localhost" \
                    --title="My WordPress Site" \
                    --admin_user="$WP_ADMIN_USER" \
                    --admin_password="$WP_ADMIN_PASSWORD" \
                    --admin_email="$WP_ADMIN_EMAIL" \
                    --path='/var/www/wordpress' \
                    --allow-root

    # Ajoute un autre utilisateur
    wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --path='/var/www/wordpress' --allow-root
fi

# Créer le dossier /run/php si non existant
mkdir -p /run/php

# Démarrer PHP-FPM
/usr/sbin/php-fpm7.3 -F
