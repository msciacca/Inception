#!/bin/sh

echo "[Inception-MariaDB] Initializing the database"

mysql_install_db

mysqld --bind-address=127.0.0.1 --user=root --datadir=/data --skip-networking=0 &
SQL_PID=$!

sleep 1

echo "[Inception-MariaDB] Creating user and databases"
echo "CREATE USER '$MYSQL_USERNAME'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root

echo "CREATE DATABASE $MYSQL_WORDPRESS_DATABASE;" | mysql -u root

echo "GRANT ALL PRIVILEGES ON wordpress.* TO '$MYSQL_USERNAME'@'%';" | mysql -u root

echo "[Inception-MariaDB] Rebooting the database"
kill $SQL_PID
wait $SQL_PID

mysqld --bind-address=0.0.0.0 --user=root --datadir=/data --skip-networking=0
