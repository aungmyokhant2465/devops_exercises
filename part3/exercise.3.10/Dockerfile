FROM node:16-alpine

WORKDIR /usr/src/app

COPY . .

RUN adduser -D appuser && chown -R appuser . && npm install

USER appuser

CMD node index.js