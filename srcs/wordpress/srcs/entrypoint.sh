#!/bin/sh

sed -i "s/CHANGETOIP/`cat /tmp/ip`/g" /etc/wordpress/wp-config.php

sleep 5
sh /tmp/launch-wordpress.sh & php -S 0.0.0.0:5050 -t /etc/wordpress/
