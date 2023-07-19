FROM alpine:3.17

EXPOSE 6379
RUN apk add redis
COPY tools/setup.sh /usr/local/bin/

ENTRYPOINT ["sh", "/usr/local/bin/setup.sh"]