#!/bin/bash

set -e

if [ -z "$TULEAP_WEB_PORT_80_TCP_ADDR" ]; then
  echo "*** ERROR: Must run with --link some-container:tuleap-web"
  exit 1
fi

if [ ! -d "/data/ssl" ]; then
  mkdir -p /data/ssl
  openssl genrsa -out /data/ssl/server.key 1024
  openssl req -new -subj "/C=FR/ST=Denial/L=Springfield/O=Dis/CN=*" -key /data/ssl/server.key -out /data/ssl/server.csr
  openssl x509 -req -days 365 -in /data/ssl/server.csr -signkey /data/ssl/server.key -out /data/ssl/server.crt
fi

if [ ! -d "/data/etc/nginx/upstream" ]; then
  mkdir -p /data/etc/nginx/upstream/
  cp /root/nginx/upstream/* /data/etc/nginx/upstream/
fi

if [ ! -d "/data/etc/nginx/location" ]; then
  mkdir -p /data/etc/nginx/location/
  cp /root/nginx/location/* /data/etc/nginx/location/
fi

sed -i -e "s/server .*/server $TULEAP_WEB_PORT_80_TCP_ADDR:80;/" /data/etc/nginx/upstream/tuleap.conf

exec /opt/rh/nginx16/root/usr/sbin/nginx
