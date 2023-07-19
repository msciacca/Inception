#!/bin/sh

echo "[Inception-Nginx] Creating the SSL Certificate"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/msciacca.42.fr.key -out /etc/ssl/msciacca.42.fr.crt -subj "/C=IT/L=Rome/O=42Roma/OU=student/CN=msciacca.42.fr"

echo "[Inception-Nginx] Creating Grafana users"
htpasswd -c -b /etc/nginx/.htpasswd-grafana $GRAFANA_USERNAME $GRAFANA_PASSWORD

echo "[Inception-Nginx] Waiting Grafana..."
while ! nc -z grafana 3000; do   
    sleep 0.1
done

echo "[Inception-Nginx] Waiting Static Website..."
while ! nc -z static_website 3000; do   
    sleep 0.1
done

echo "[Inception-Nginx] Grafana is up, starting Nginx"
nginx -g "daemon off;"
