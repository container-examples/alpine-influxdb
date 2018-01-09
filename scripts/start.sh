#!/bin/sh

chown -R influxdb:influxdb /var/lib/influxdb
exec su-exec influxdb /usr/bin/influxd $@