#!/bin/sh

sed -i "s/CHANGETOIP/`cat /tmp/ip`/g" /usr/share/grafana/conf/provisioning/datasources/datasources.yaml

/usr/sbin/grafana-server --config=/usr/share/grafana/conf/defaults.ini --homepath=/usr/share/grafana
