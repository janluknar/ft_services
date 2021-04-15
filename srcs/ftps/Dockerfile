FROM alpine:3.12.0
MAINTAINER jluknar-

RUN apk upgrade
RUN apk add openssl vsftpd
RUN apk add jq curl
ENV API_URL=https://kubernetes
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=ES/ST=JEREZ/O=solucionescipriano.es/CN=CIPRIANO' -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt
RUN mkdir -p /var/ftp

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY setup.sh /tmp/
RUN chmod +x /tmp/setup.sh
RUN mkdir /jluknar

EXPOSE 20 21 30020

ENTRYPOINT ["/tmp/setup.sh"]