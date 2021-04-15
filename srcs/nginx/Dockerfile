FROM alpine:3.12.0
MAINTAINER jluknar-
RUN apk update
RUN apk upgrade
COPY srcs/ip /tmp/

RUN apk add nginx
COPY srcs/default.conf /etc/nginx/conf.d

RUN apk add openssl
COPY srcs/nginx.crt /etc/ssl/certs/
COPY srcs/nginx.key /etc/ssl/private/
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 3650 \
            -nodes -out /etc/ssl/certs/nginx.crt  -keyout /etc/ssl/private/nginx.key \
            -subj "/C=ES/ST=JEREZ/L=JEREZ J EREZ/O=Cipriano/OU=Cipriano/CN=solucionescipriano.es"
RUN apk add openssh-server

EXPOSE 80 443 30022

RUN rm -rf /var/cache/apk*
RUN mkdir - /run/nginx/
COPY srcs/entrypoint.sh /tmp/

ENTRYPOINT ["sh", "/tmp/entrypoint.sh"]
