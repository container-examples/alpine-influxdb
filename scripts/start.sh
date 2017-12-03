#!/bin/sh

chmod +x /usr/bin/gosu
chown -R influxdb:influxdb /var/lib/influxdb

echo "Start InfluxDB"
/usr/bin/gosu influxdb /usr/bin/influxd -config /etc/influxdb/influxdb.conf