#!/bin/sh
sed -i "s/CHANGETOIP/`cat /tmp/ip`/g" /etc/telegraf/telegraf.conf

cd /etc/telegraf/ && ./telegraf
