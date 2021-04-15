FROM alpine:3.12.0
MAINTAINER jluknar

RUN apk update && apk upgrade
COPY srcs/ip /tmp

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.14.0-static_linux_amd64.tar.gz
RUN tar -xzf telegraf-1.14.0-static_linux_amd64.tar.gz
RUN mv /telegraf /etc/
RUN rm -rf telegraf-1.14.0-static_linux_amd64.tar.gz

COPY srcs/telegraf.conf /etc/telegraf/

RUN rm -rf /var/cache/apk/*
COPY srcs/entrypoint.sh /tmp/
ENTRYPOINT ["sh", "/tmp/entrypoint.sh"]

