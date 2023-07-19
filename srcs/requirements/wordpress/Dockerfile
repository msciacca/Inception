FROM alpine:3.17

EXPOSE 9000
RUN apk add curl php php-fpm php-mysqli php-curl php-dom php-exif php-fileinfo php-xml php-zip php-phar php-tokenizer
RUN apk add php8-pecl-redis --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

RUN mkdir -p /var/www/html
COPY tools/setup.sh /usr/local/bin/

ENTRYPOINT ["/bin/sh", "/usr/local/bin/setup.sh"]