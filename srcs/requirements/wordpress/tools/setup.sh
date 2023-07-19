#!/bin/sh

cd /var/www/html

if [ -f "wp-config.php" ]; then
  echo "[Inception-Wordpress] Wordpress files found, not downloading it again."
else 
  echo "[Inception-Wordpress] Downloading Wordpress"
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  php wp-cli.phar core download --allow-root

  echo "[Inception-Wordpress] Setting up basic Wordpress settings"
  mv wp-config-sample.php wp-config.php

  sed "s/database_name_here/$MYSQL_WORDPRESS_DATABASE/1" -i -r wp-config.php
  sed "s/username_here/$MYSQL_USERNAME/1" -i -r wp-config.php
  sed "s/password_here/$MYSQL_PASSWORD/1" -i -r wp-config.php
  sed "s/localhost/mariadb/1" -i -r wp-config.php

  echo "[Inception-Wordpress] Waiting MariaDB..."
  while ! nc -z mariadb 3306; do   
    sleep 0.1
  done
  echo "[Inception-Wordpress] MariaDB is online"


  echo "[Inception-Wordpress] Waiting Redis..."
  while ! nc -z redis 6379; do   
    sleep 0.1
  done
  echo "[Inception-Wordpress] Redis is online"

  echo "[Inception-Wordpress] Setting up Wordpress website and users"
  php wp-cli.phar core install --url=$DOMAIN_NAME/ --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USERNAME --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email --allow-root
  php wp-cli.phar user create $WORDPRESS_USER_USERNAME $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD --allow-root
  
  echo "[Inception-Wordpress] Installing WP Statistics"
  php wp-cli.phar plugin install wp-statistics --activate

  echo "[Inception-Wordpress] Installing Redis Cache"
  php wp-cli.phar plugin install redis-cache --activate
  php wp-cli.phar config set WP_REDIS_HOST redis
  php wp-cli.phar config set WP_REDIS_PORT 6379
  php wp-cli.phar redis enable

  rm wp-cli.phar
fi

echo "[Inception-Wordpress] Updating PHP-FPM configuration"
sed "s/127.0.0.1:9000/0.0.0.0:9000/1" -i -r /etc/php81/php-fpm.d/www.conf

echo "[Inception-Wordpress] Starting PHP-FPM"
/usr/sbin/php-fpm81 -F