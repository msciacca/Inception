FROM alpine:3.17

EXPOSE 21

RUN apk update && apk add vsftpd

COPY conf/vsftpd.conf /etc/

COPY tools/setup.sh /usr/local/bin/

ENTRYPOINT ["sh", "/usr/local/bin/setup.sh"]