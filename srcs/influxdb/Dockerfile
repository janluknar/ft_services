FROM alpine:3.12.0
MAINTAINER jluknar
RUN apk update && apk upgrade
COPY srcs/ip /tmp/

RUN apk add influxdb
COPY srcs/influxdb.conf /etc/

VOLUME ["/var/lib/influxdb"]

RUN rm -rf /var/cache/apk/*
COPY srcs/entrypoint.sh /tmp/
ENTRYPOINT ["sh", "/tmp/entrypoint.sh"]
