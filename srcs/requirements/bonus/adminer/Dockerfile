FROM alpine:3.17

EXPOSE 9000

RUN apk add wget php php-fpm php-mysqli php-session
RUN mkdir -p /var/www/html
RUN cd /var/www/html; wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php -O index.php
COPY tools/setup.sh /usr/local/bin/

ENTRYPOINT ["/bin/sh", "/usr/local/bin/setup.sh"]