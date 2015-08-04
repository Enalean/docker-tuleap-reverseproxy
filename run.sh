#!/bin/bash

set -e

if [ -z "$TULEAP_WEB_PORT_80_TCP_ADDR" ]; then
  echo "*** ERROR: Must run with --link some-container:tuleap-web"
  exit 1
fi

if [ ! -d "/reverseproxy_data/etc/nginx/upstream" ]; then
  mkdir -p /reverseproxy_data/etc/nginx/upstream/
  cp /root/nginx/upstream/* /reverseproxy_data/etc/nginx/upstream/
fi

if [ ! -d "/reverseproxy_data/etc/nginx/location" ]; then
  mkdir -p /reverseproxy_data/etc/nginx/location/
  cp /root/nginx/location/* /reverseproxy_data/etc/nginx/location/
fi

sed -i -e "s/server .*/server $TULEAP_WEB_PORT_80_TCP_ADDR:80;/" /reverseproxy_data/etc/nginx/upstream/tuleap.conf

/root/reload.sh &

exec /opt/rh/nginx16/root/usr/sbin/nginx
