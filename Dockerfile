FROM alpine:3.7

LABEL MAINTAINER="Aurelien PERRIER <perrie_a@etna-alternance.net>"
LABEL APP="influxdb"
LABEL APP_VERSION="1.4.2"
LABEL APP_REPOSITORY="https://github.com/influxdata/influxdb/releases"

ENV TIMEZONE Europe/Paris
ENV INFLUXDB_VERSION 1.4.2

# Installing packages
RUN apk add --no-cache su-exec

# Work path
WORKDIR /scripts

# Downloading binaries
ADD https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz ./
RUN addgroup influxdb && \
        adduser -s /bin/false -G influxdb -S -D influxdb

# Coping config & scripts
COPY ./files/influxdb.conf /etc/influxdb/influxdb.conf
COPY ./scripts/start.sh start.sh

# Installing binaries
RUN tar -C . -xzf influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz && \
        chmod +x influxdb-*/* && \
        cp -a influxdb-*/* /usr/bin/ && \
        rm -rf *.tar.gz* influxdb-*/

VOLUME [ "/var/lib/influxdb" ]

EXPOSE 8086

ENTRYPOINT [ "./start.sh" ]