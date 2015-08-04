#!/bin/bash

set -e

# watch for changes in /mnt and update nginx if there is one on /mnt/proxy
while true; do
    changes=$(inotifywait -e close_write,moved_to,create /reverseproxy_data/etc/nginx/location);
    echo "Something changed, reload nginx ($changes)"
    /opt/rh/nginx16/root/usr/sbin/nginx -s reload
    #changes=${changes#/mnt/ * };
    #if [ "$changes" = "proxy" ]; then
    #	if ! cmp /mnt/proxy /etc/nginx/sites-enabled/proxy; then
    #	    cp /mnt/proxy /etc/nginx/sites-enabled/proxy
    #	    /etc/init.d/nginx reload
    #	fi
    #fi
done
