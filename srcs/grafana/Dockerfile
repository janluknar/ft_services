FROM alpine:3.12.0
MAINTAINER jluknar

RUN apk update && apk upgrade
COPY srcs/ip /tmp/

RUN apk add grafana --repository=http://dl-3.alpinelinux.org/alpine/edge/testing/
COPY srcs/datasources.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY srcs/dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/
RUN mkdir -p /var/lib/grafana/dashboards
COPY srcs/x.json /var/lib/grafana/dashboards/

EXPOSE 3000

RUN rm -rf /var/cache/apk/*
COPY srcs/entrypoint.sh /tmp/

ENTRYPOINT ["sh", "/tmp/entrypoint.sh"]
