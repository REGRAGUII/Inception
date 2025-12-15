#!/bin/sh
set -e

# Create necessary directories for PHP-FPM
mkdir -p /run/php
chown -R www-data:www-data /run/php

cd /var/www/wordpress

# Wait for MariaDB to be ready
while ! mariadb -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" -e "SELECT 1" >/dev/null 2>&1; do
    echo "Waiting for MariaDB..."
    sleep 2
done

echo "MariaDB is ready!"

# Configure and install WordPress if not already done
if [ ! -f wp-config.php ]; then
    echo "Creating wp-config.php..."
    wp config create \
      --allow-root \
      --dbname="$MYSQL_DATABASE" \
      --dbuser="$MYSQL_USER" \
      --dbpass="$MYSQL_PASSWORD" \
      --dbhost="mariadb:3306"

    echo "Installing WordPress..."
    wp core install \
      --allow-root \
      --url="$DOMAIN_NAME" \
      --title="$WP_TITLE" \
      --admin_user="$WP_ADMIN_NAME" \
      --admin_password="$WP_ADMIN_PASSWORD" \
      --admin_email="$WP_ADMIN_MAIL" \
      --skip-email

    echo "Creating additional WordPress user..."
    wp user create \
      --allow-root \
      "$WP_USER_NAME" \
      "$WP_USER_MAIL" \
      --user_pass="$WP_USER_PASSWORD" \
      --role=author

    echo "WordPress setup complete!"
fi

echo "Starting PHP-FPM..."
exec php-fpm7.4 -F