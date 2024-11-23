# use apline version to minize base image
FROM node:16-alpine

WORKDIR /usr/src/app

COPY . .

# add non-root user and set required permission and use only RUN to reduce layers 
RUN adduser -D appuser && npm install && chown -R appuser . 

# use non-root for security purpose
USER appuser

CMD node index.js