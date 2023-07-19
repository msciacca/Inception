#!/bin/sh

echo "[Inception-Adminer] Updating PHP-FPM configuration"
sed "s/127.0.0.1:9000/0.0.0.0:9000/1" -i -r /etc/php81/php-fpm.d/www.conf

echo "[Inception-Adminer] Starting PHP-FPM"
/usr/sbin/php-fpm81 -F