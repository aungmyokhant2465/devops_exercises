FROM docker

WORKDIR /usr/src/app

COPY builder.sh .

RUN chmod +x builder.sh

ENTRYPOINT [ "sh", "builder.sh" ]