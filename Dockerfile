FROM alpine:3.6

LABEL MAINTAINER="Aurelien PERRIER <perrie_a@etna-alternance.net>"
LABEL APP="influxdb"
LABEL APP_VERSION="1.4.2"
LABEL APP_REPOSITORY="https://github.com/influxdata/influxdb/releases"
LABEL APP_DESCRIPTION="logging"

ENV TIMEZONE Europe/Paris
ENV INFLUXDB_VERSION 1.4.2
ENV GOSU_VERSION 1.10

# Installing packages
RUN apk add --no-cache --virtual .build-deps wget tar

# Downloading binaries
RUN wget --no-check-certificate -q https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz
RUN wget --no-check-certificate -q -O /usr/bin/gosu https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64

# Coping config & scripts
COPY ./files/influxdb.conf /etc/influxdb/influxdb.conf
COPY ./scripts/start.sh start.sh

# Installing binaries
RUN tar -C . -xzf influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz && \
        chmod +x influxdb-*/* && \
        cp -a influxdb-*/* /usr/bin/ && \
        rm -rf *.tar.gz* /root/.gnupg influxdb-*/ && \
        addgroup influxdb && \
        adduser -s /bin/false -G influxdb -S -D influxdb && \
        apk del .build-deps

VOLUME [ "/var/lib/influxdb" ]

EXPOSE 8086

ENTRYPOINT [ "./start.sh" ]