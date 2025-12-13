#!/bin/bash
set -e

# Ensure required directories exist
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Initialize database if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysqld --initialize-insecure --user=mysql
fi

echo "Starting temporary MariaDB server for initialization..."
mysqld_safe --skip-networking &
sleep 5

echo "Setting root password..."
mysql --protocol=socket -uroot -e \
    "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

echo "Creating WordPress database..."
mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e \
    "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

echo "Creating WordPress user..."
mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e \
    "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

echo "Assigning privileges..."
mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e \
    "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"

mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

echo "Shutting down temporary server..."
mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

echo "Starting MariaDB normally..."
exec mysqld_safe
