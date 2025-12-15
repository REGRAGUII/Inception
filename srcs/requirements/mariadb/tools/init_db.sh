#!/bin/sh
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# ---------- ONE-TIME INITIALIZATION ----------
if [ ! -f /var/lib/mysql/.initialized ]; then
    echo "First-time MariaDB initialization"

    mysqld_safe --skip-networking &
    sleep 5

    mysql -uroot <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

    touch /var/lib/mysql/.initialized
fi
echo "RUning"
# ---------- NORMAL RUNTIME ----------
exec mysqld_safe
