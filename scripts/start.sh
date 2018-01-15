#!/bin/sh

chown -R influxdb:influxdb /var/lib/influxdb
exec su-exec influxdb /usr/bin/influxd -config /etc/influxdb/influxdb.conf