chmod 644 /etc/ssl/certs/nginx.crt
chmod 600 /etc/ssl/private/nginx.key

echo "Port 30022" >> /etc/ssh/sshd_config

ssh-keygen -A
adduser --disabled-password "admin"
echo "admin:admin" | chpasswd

/usr/sbin/sshd
/usr/sbin/nginx -g 'daemon off;'
