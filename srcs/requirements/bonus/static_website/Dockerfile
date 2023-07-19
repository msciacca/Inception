FROM alpine:3.17

EXPOSE 3000
RUN apk add -y --update npm

COPY ./tools /home/app

WORKDIR /home/app

RUN npm init -y && npm install express ejs -y

CMD ["node", "server.js"]